-- Each status line is of the form:
-- %-0{minwid}.{maxwid}{item}
-- More information see :help statusline
-- How to call Lua functions from Vimscript: see :help v:lua-call

function get_lsp_status()
  local error_count, warning_count, info_count, hint_count
  local diagnostics = vim.diagnostic.get(0)
  local count = { 0, 0, 0, 0 }
  for _, diagnostic in ipairs(diagnostics) do
    if vim.startswith(vim.diagnostic.get_namespace(diagnostic.namespace).name, 'vim.lsp') then
      count[diagnostic.severity] = count[diagnostic.severity] + 1
    end
  end
  error_count = count[vim.diagnostic.severity.ERROR] > 0 and " E:" .. count[vim.diagnostic.severity.ERROR] or ""
  warning_count = count[vim.diagnostic.severity.WARN] > 0 and " W:" .. count[vim.diagnostic.severity.WARN] or ""
  info_count = count[vim.diagnostic.severity.INFO] > 0 and " I:" .. count[vim.diagnostic.severity.INFO] or ""
  hint_count = count[vim.diagnostic.severity.HINT] > 0 and " H:" .. count[vim.diagnostic.severity.HINT] or ""

  local lsp_status_string = string.format("(LSP%s%s%s%s)",
    error_count, warning_count, info_count, hint_count)

  return lsp_status_string ~= "(LSP)" and lsp_status_string or ""
end

function get_git_status()
  local git_status = vim.b.gitsigns_status_dict or {}

  local git_branch = git_status.head ~= nil and git_status.head ~= '' and git_status.head or "?"
  local git_added = git_status.added ~= nil and git_status.added > 0 and "+" .. git_status.added .. " " or ""
  local git_changed = git_status.changed ~= nil and git_status.changed > 0 and "~" .. git_status.changed .. " " or ""
  local git_removed = git_status.removed ~= nil and git_status.removed > 0 and "-" .. git_status.removed .. " " or ""

  local git_status_string = string.format("(%s%s%sGit:%s) ",
    git_added, git_changed, git_removed, git_branch)

  return git_status_string ~= "(Git:?) " and git_status_string or ""
end

local function status_line()
  local file_name = "%-.50f"
  local modified = "%-m"
  local read_only = "%-r"
  local lsp_status = "%{v:lua.get_lsp_status()}"
  local right_align = "%="
  local git_status = "%{v:lua.get_git_status()}"
  -- local file_type = "%y"
  -- local file_encoding = "%{&fileencoding?&fileencoding:&encoding}"
  -- local file_format = "[%{&fileformat}]"
  local pct_thru_file = "%p%%"
  local line_no = "%l,%c%V"

  return string.format(
    "%s%s%s %s%s %s%s  %s",
    file_name,
    modified,
    read_only,
    lsp_status,
    right_align,
    git_status,
    pct_thru_file,
    line_no
  )
end

vim.o.statusline = status_line()
