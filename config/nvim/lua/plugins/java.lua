return {
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = function()
      local jdtls = require("jdtls")
      
      -- Trouve le workspace
      local project_name = vim.fn.fnamemodify(vim.fn. getcwd(), ':p:h: t')
      local workspace_dir = vim.fn.stdpath('data') .. '/site/java/workspace-root/' .. project_name
      
      -- Trouve l'installation de jdtls via Mason
      local mason_path = vim.fn.stdpath('data') .. '/mason'
      local jdtls_path = mason_path .. '/packages/jdtls'
      local launcher_jar = vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar')
      
      local config = {
        cmd = {
          'java',
          '-Declipse.application=org.eclipse.jdt.ls.core.id1',
          '-Dosgi. bundles.defaultStartLevel=4',
          '-Declipse. product=org.eclipse.jdt.ls.core.product',
          '-Dlog.protocol=true',
          '-Dlog.level=ALL',
          '-Xmx1g',
          '--add-modules=ALL-SYSTEM',
          '--add-opens', 'java.base/java. util=ALL-UNNAMED',
          '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
          '-jar', launcher_jar,
          '-configuration', jdtls_path ..  '/config_linux',
          '-data', workspace_dir,
        },
        root_dir = jdtls.setup.find_root({'. git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'}),
        settings = {
          java = {
            signatureHelp = { enabled = true },
            contentProvider = { preferred = 'fernflower' },
            completion = {
              favoriteStaticMembers = {
                "org.junit.Assert.*",
                "org.junit. Assume.*",
                "org. junit.jupiter.api.Assertions.*",
                "org.mockito. Mockito.*"
              },
            },
          }
        },
        init_options = {
          bundles = {}
        },
      }
      
      jdtls.start_or_attach(config)
    end,
  }
}
