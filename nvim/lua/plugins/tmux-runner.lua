-- Custom tmux runner for Python and Rust
-- Function to run current file in adjacent tmux pane
local function run_in_tmux()
  -- Save the file first before running
  vim.cmd('write')

  local filetype = vim.bo.filetype
  local filename = vim.fn.expand('%:p') -- Full path to file
  local file_dir = vim.fn.expand('%:p:h') -- Directory of the file

  -- Map filetypes to run commands
  local runners = {
    python = string.format('cd "%s" && uv run "%s"', file_dir, filename),
    rust = string.format('cd "%s" && cargo run', file_dir),
  }

  local cmd = runners[filetype]

  -- Check if filetype is supported
  if not cmd then
    vim.notify("No runner configured for filetype: " .. filetype, vim.log.levels.WARN)
    return
  end

  -- Confirm we recognized the filetype
  vim.notify("Detected " .. filetype .. " file, running...", vim.log.levels.INFO)

  -- Check if we're in a tmux session
  local in_tmux = os.getenv("TMUX")
  if not in_tmux then
    vim.notify("Not in a tmux session!", vim.log.levels.ERROR)
    return
  end

  -- Get the number of panes
  local pane_count = vim.fn.system("tmux list-panes | wc -l")
  pane_count = tonumber(pane_count)

  -- If only one pane, create a vertical split on the right
  if pane_count == 1 then
    vim.fn.system(string.format("tmux split-window -h -c '%s'", file_dir))
  end

  -- Send the command to the next pane
  local tmux_cmd = string.format("tmux send-keys -t {next} '%s' Enter", cmd)
  vim.fn.system(tmux_cmd)
end

-- Keybinding
vim.keymap.set('n', '<leader>r', run_in_tmux, {
  desc = 'Run file in tmux pane (Python with uv, Rust with cargo)',
  silent = true
})

-- Return empty table so Lazy.nvim doesn't complain
return {}
