local M = {}

---@param name string
function M.opts(name)
  local plugin = M.get_plugin(name)
  if not plugin then
    return {}
  end
  local Plugin = require 'lazy.core.plugin'
  return Plugin.values(plugin, 'opts', false)
end

---@param name string
function M.get_plugin(name)
  return require('lazy.core.config').spec.plugins[name]
end

---@param name string
---@param path string?
function M.get_plugin_path(name, path)
  local plugin = M.get_plugin(name)
  path = path and '/' .. path or ''
  return plugin and (plugin.dir .. path)
end

---@param plugin string
function M.has(plugin)
  return M.get_plugin(plugin) ~= nil
end

---@param name string
---@param fn fun(name:string)
function M.on_load(name, fn)
  if M.is_loaded(name) then
    fn(name)
  else
    vim.api.nvim_create_autocmd('User', {
      pattern = 'LazyLoad',
      callback = function(event)
        if event.data == name then
          fn(name)
          return true
        end
      end,
    })
  end
end

local _defaults = {} ---@type table<string, boolean>

-- Determines whether it's safe to set an option to a default value.
--
-- It will only set the option if:
-- * it is the same as the global value
-- * it's current value is a default value
-- * it was last set by a script in $VIMRUNTIME
---@param option string
---@param value string|number|boolean
---@return boolean was_set
function M.set_default(option, value)
  local l = vim.api.nvim_get_option_value(option, { scope = 'local' })
  local g = vim.api.nvim_get_option_value(option, { scope = 'global' })

  _defaults[('%s=%s'):format(option, value)] = true
  local key = ('%s=%s'):format(option, l)

  local source = ''
  if l ~= g and not _defaults[key] then
    -- Option does not match global and is not a default value
    -- Check if it was set by a script in $VIMRUNTIME
    local info = vim.api.nvim_get_option_info2(option, { scope = 'local' })
    ---@param e vim.fn.getscriptinfo.ret
    local scriptinfo = vim.tbl_filter(function(e)
      return e.sid == info.last_set_sid
    end, vim.fn.getscriptinfo())
    source = scriptinfo[1] and scriptinfo[1].name or ''
    local by_rtp = #scriptinfo == 1 and vim.startswith(scriptinfo[1].name, vim.fn.expand '$VIMRUNTIME')
    if not by_rtp then
      return false
    end
  end
  vim.api.nvim_set_option_value(option, value, { scope = 'local' })
  return true
end

return M
