-- nerd_font_check.lua
local function has_nerd_font()
  local os_name = vim.loop.os_uname().sysname

  if os_name == "Linux" or os_name == "Darwin" then
    -- Use fc-list (available if fontconfig is installed)
    local fonts = vim.fn.systemlist("fc-list :family")
    for _, f in ipairs(fonts) do
      if f:match("Nerd Font") then
        return true
      end
    end
    return false

  elseif os_name == "Windows_NT" then
    -- Query Windows Fonts dir (PowerShell)
    local fonts = vim.fn.systemlist(
      'powershell -Command "Get-ChildItem C:\\Windows\\Fonts | Select-String -Pattern \'Nerd Font\'"'
    )
    return #fonts > 0
  end

  -- If detection not possible, fall back to manual flag
  return vim.g.has_nerd_font or false
end

if not has_nerd_font() then
  vim.schedule(function()
    vim.notify("⚠️ Nerd Font not detected. Some icons may not render.", vim.log.levels.WARN)
  end)
end

