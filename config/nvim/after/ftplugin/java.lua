-- Configuration qui se lance UNIQUEMENT pour les fichiers . java
local jdtls_ok, jdtls = pcall(require, "jdtls")
if not jdtls_ok then
  vim.notify("jdtls not found, install with : Mason", vim.log.levels. WARN)
  return
end

local project_name = vim.fn. fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath('data') .. '/jdtls-workspace/' .. project_name

local config = {
  cmd = {
    'jdtls',
    '-data', workspace_dir,
  },
  root_dir = vim.fs.dirname(vim.fs.find({'.gradlew', '. git', 'mvnw', 'pom.xml'}, { upward = true })[1]),
}

jdtls.start_or_attach(config)
