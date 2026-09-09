local PROXY = 'http://127.0.0.1:10808'
local VARS = { 'http_proxy', 'https_proxy', 'HTTP_PROXY', 'HTTPS_PROXY', 'ALL_PROXY', 'all_proxy' }
-- sidekick tools that should inherit the toggle (tmux needs explicit -e)
local SIDEKICK_TOOLS = { 'copilot', 'cursor' }

local function proxy_enabled()
  return vim.env.http_proxy == PROXY or vim.env.HTTP_PROXY == PROXY
end

local function set_proxy(url)
  for _, var in ipairs(VARS) do
    vim.env[var] = url
  end
end

--- Push proxy into sidekick tool env so tmux sessions get `-e` / `-u`.
--- Already-running sessions keep their old env; reopen them after toggling.
local function sync_sidekick(url)
  local ok, Config = pcall(require, 'sidekick.config')
  if not ok then
    return
  end

  for _, name in ipairs(SIDEKICK_TOOLS) do
    local tool = Config.cli.tools[name]
    if tool then
      tool.env = tool.env or {}
      for _, var in ipairs(VARS) do
        -- false => sidekick unsets via tmux `-u` / omits from job env
        tool.env[var] = url or false
      end
    end
  end
end

local function apply(url)
  set_proxy(url)
  sync_sidekick(url)
end

vim.api.nvim_create_user_command('ToggleProxy', function()
  if proxy_enabled() then
    apply(nil)
    vim.notify('Proxy disabled (reopen sidekick CLIs to apply)', vim.log.levels.INFO)
  else
    apply(PROXY)
    vim.notify('Proxy enabled: ' .. PROXY .. ' (reopen sidekick CLIs to apply)', vim.log.levels.INFO)
  end
end, {
  desc = string.format('Toggle HTTP proxy between %s and unset', PROXY),
})

-- Enable on launch (vim.env immediately; sidekick after it loads)
apply(PROXY)

vim.api.nvim_create_autocmd('User', {
  pattern = 'LazyLoad',
  callback = function(ev)
    if ev.data == 'sidekick.nvim' and proxy_enabled() then
      sync_sidekick(PROXY)
    end
  end,
})
