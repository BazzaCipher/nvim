local function win_has_nerd_font_ps()
  local cmd = table.concat({
    "powershell",
    "-NoProfile",
    "-NonInteractive",
    "-ExecutionPolicy", "Bypass",
    "-Command",
    -- exit 0 if any filename matches; else 1
    [[
      $p = 'C:\Windows\Fonts';
      if (Get-ChildItem -Name $p | Select-String -Pattern 'Nerd Font' -Quiet) { exit 0 } else { exit 1 }
    ]]
  }, " ")

  vim.fn.system(cmd)
  return vim.v.shell_error == 0
end

local function has_nerd_font()
  local os_name = (vim.loop or vim.uv).os_uname().sysname
  if os_name == "Windows_NT" then
    return win_has_nerd_font_ps()
  elseif os_name == "Linux" or os_name == "Darwin" then
    if vim.fn.executable("fc-list") == 1 then
      -- quick grep-like filter without building a Lua table
      local out = vim.fn.system("fc-list :family | grep -i 'nerd font' >/dev/null 2>&1; printf %d $?")
      return tonumber(out) == 0
    end
    return vim.g.has_nerd_font or false
  else
    return vim.g.has_nerd_font or false
  end
end

local function check()
  local ok_status = has_nerd_font()
  if ok_status ~= true then
    vim.notify("No Nerd Font detected — some icons may not render ⚠️", vim.log.levels.WARN)
    vim.notify("Install any Nerd Font (e.g. Hack Nerd Font) and set it in your terminal.", vim.log.levels.INFO)
  end
end

-- Run check automatically on require
vim.schedule(check)

