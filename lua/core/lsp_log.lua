local M = {}

local log_dir = vim.fn.stdpath 'state'
local log_retention_days = 7

function M.get_log_path(date)
  date = date or os.date '%Y-%m-%d'
  return string.format('%s/lsp-%s.log', log_dir, date)
end

function M.setup_daily_logs()
  local today_log = M.get_log_path()

  vim.lsp.log._set_filename(today_log)

  vim.lsp.log.set_level(vim.log.levels.WARN)
end

function M.clean_old_logs(days_to_keep)
  days_to_keep = days_to_keep or log_retention_days

  local cutoff_time = os.time() - (days_to_keep * 24 * 60 * 60)

  local log_files = vim.fn.glob(log_dir .. '/lsp-*.log', false, true)

  local removed_count = 0
  local removed_size = 0

  for _, log_file in ipairs(log_files) do
    local stat = vim.uv.fs_stat(log_file)
    if stat and stat.mtime.sec < cutoff_time then
      local size = stat.size
      local ok = vim.uv.fs_unlink(log_file)
      if ok then
        removed_count = removed_count + 1
        removed_size = removed_size + size
      end
    end
  end

  if removed_count > 0 then
    local size_mb = string.format('%.2f', removed_size / 1024 / 1024)
    vim.notify(
      string.format('Cleaned %d old LSP log file(s), freed %s MB', removed_count, size_mb),
      vim.log.levels.INFO
    )
  end

  return removed_count
end

function M.open_today_log()
  local log_path = M.get_log_path()
  if vim.fn.filereadable(log_path) == 1 then
    vim.cmd('edit ' .. vim.fn.fnameescape(log_path))
  else
    vim.notify('No log file for today: ' .. log_path, vim.log.levels.WARN)
  end
end

function M.list_logs()
  local log_files = vim.fn.glob(log_dir .. '/lsp-*.log', false, true)

  if #log_files == 0 then
    vim.notify('No LSP log files found', vim.log.levels.INFO)
    return
  end

  local lines = { 'LSP Log Files:' }
  local total_size = 0

  for _, log_file in ipairs(log_files) do
    local stat = vim.uv.fs_stat(log_file)
    if stat then
      local size_mb = string.format('%.2f MB', stat.size / 1024 / 1024)
      local date = os.date('%Y-%m-%d %H:%M:%S', stat.mtime.sec)
      table.insert(lines, string.format('  %s - %s (modified: %s)', vim.fn.fnamemodify(log_file, ':t'), size_mb, date))
      total_size = total_size + stat.size
    end
  end

  local total_mb = string.format('%.2f MB', total_size / 1024 / 1024)
  table.insert(lines, string.format('\nTotal: %d file(s), %s', #log_files, total_mb))

  vim.notify(table.concat(lines, '\n'), vim.log.levels.INFO)
end

function M.setup()
  M.setup_daily_logs()

  M.clean_old_logs()

  vim.api.nvim_create_user_command('LspLogClean', function(opts)
    local days = tonumber(opts.args) or log_retention_days
    M.clean_old_logs(days)
  end, {
    nargs = '?',
    desc = 'Clean LSP logs older than N days (default: 7)',
  })

  vim.api.nvim_create_user_command('LspLogOpen', function()
    M.open_today_log()
  end, {
    desc = "Open today's LSP log file",
  })

  vim.api.nvim_create_user_command('LspLogList', function()
    M.list_logs()
  end, {
    desc = 'List all LSP log files',
  })
end

return M
