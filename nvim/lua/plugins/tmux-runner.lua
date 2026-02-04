-- Custom tmux runner for Python and Rust

-- Cache for project roots per buffer
local project_root_cache = {}

-- Helper function to find project root (with caching)
local function find_project_root()
  local bufnr = vim.api.nvim_get_current_buf()

  -- Return cached value if it exists
  if project_root_cache[bufnr] then
    return project_root_cache[bufnr]
  end

  local markers = {
    'pyproject.toml',  -- Python
    'Cargo.toml',      -- Rust
    'go.mod',          -- Go
    'package.json',    -- JS/TS
    'Gemfile',         -- Ruby
    '.git',            -- Generic
  }

  local current_dir = vim.fn.expand('%:p:h')

  -- Search upwards for project markers
  while current_dir ~= '/' do
    for _, marker in ipairs(markers) do
      if vim.fn.filereadable(current_dir .. '/' .. marker) == 1 or
         vim.fn.isdirectory(current_dir .. '/' .. marker) == 1 then
        -- Cache the result
        project_root_cache[bufnr] = current_dir
        return current_dir
      end
    end
    -- Move up one directory
    current_dir = vim.fn.fnamemodify(current_dir, ':h')
  end

  -- If no marker found, return current file's directory
  local fallback = vim.fn.expand('%:p:h')
  project_root_cache[bufnr] = fallback
  return fallback
end

-- Clear cache when buffer is deleted
vim.api.nvim_create_autocmd("BufDelete", {
  callback = function(ev)
    project_root_cache[ev.buf] = nil
  end,
})

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

  -- If only one pane, create a vertical split below
  if pane_count == 1 then
    vim.fn.system(string.format("tmux split-window -v -c '%s'", file_dir))
  end

  -- Send the command to the pane below
  local tmux_cmd = string.format("tmux send-keys -t {down-of} '%s' Enter", cmd)
  vim.fn.system(tmux_cmd)
end

-- Function to run tests in adjacent tmux pane
local function run_tests_in_tmux()
  -- Save the file first before running
  vim.cmd('write')

  local filetype = vim.bo.filetype
  local project_root = find_project_root()

  -- Map filetypes to test commands
  local test_runners = {
    python = string.format('cd "%s" && uv run pytest', project_root),
    ruby = string.format('cd "%s" && rspec', project_root),
    go = string.format('cd "%s" && go test ./...', project_root),
    rust = string.format('cd "%s" && cargo test', project_root),
    javascript = string.format('cd "%s" && npm test', project_root),
    typescript = string.format('cd "%s" && npm test', project_root),
    javascriptreact = string.format('cd "%s" && npm test', project_root),
    typescriptreact = string.format('cd "%s" && npm test', project_root),
  }

  local cmd = test_runners[filetype]

  -- Check if filetype is supported
  if not cmd then
    vim.notify("No test runner configured for filetype: " .. filetype, vim.log.levels.WARN)
    return
  end

  -- Confirm we recognized the filetype
  vim.notify("Running " .. filetype .. " tests...", vim.log.levels.INFO)

  -- Check if we're in a tmux session
  local in_tmux = os.getenv("TMUX")
  if not in_tmux then
    vim.notify("Not in a tmux session!", vim.log.levels.ERROR)
    return
  end

  -- Get the number of panes
  local pane_count = vim.fn.system("tmux list-panes | wc -l")
  pane_count = tonumber(pane_count)

  -- If only one pane, create a vertical split below
  if pane_count == 1 then
    vim.fn.system(string.format("tmux split-window -v -c '%s'", project_root))
  end

  -- Send the command to the pane below
  local tmux_cmd = string.format("tmux send-keys -t {down-of} '%s' Enter", cmd)
  vim.fn.system(tmux_cmd)
end

-- Keybindings
vim.keymap.set('n', '<leader>r', run_in_tmux, {
  desc = 'Run file in tmux pane (Python with uv, Rust with cargo)',
  silent = true
})

vim.keymap.set('n', '<leader>ta', run_tests_in_tmux, {
  desc = 'Run tests in tmux pane',
  silent = true
})

-- Return empty table so Lazy.nvim doesn't complain
return {}
