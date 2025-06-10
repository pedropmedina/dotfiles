local function get_jdtls()
  -- Find the full path to the directory where Mason has downloaded the JDTLS binaries
  local jdtls_path = vim.fn.expand '$MASON/packages/jdtls'
  -- Obtain the path to the jar which runs the language server
  local launcher = vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar')
  -- Declare white operating system we are using, windows use win, macos use mac
  local SYSTEM = 'mac'
  -- Obtain the path to configuration files for your specific operating system
  local config = jdtls_path .. '/config_' .. SYSTEM
  -- Obtain the path to the Lomboc jar
  local lombok = jdtls_path .. '/lombok.jar'

  return launcher, config, lombok
end

local function get_workspace()
  -- Get the home directory of your operating system
  local home = vim.env.HOME
  -- Determine the project name
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
  -- Create the workspace directory by concatenating the designated workspace path and the project name
  local workspace_dir = home .. '/.local/share/jdtls/' .. project_name

  return workspace_dir
end

local function java_keymaps()
  -- Allow yourself to run JdtCompile as a Vim command
  vim.cmd "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)"
  -- Allow yourself/register to run JdtUpdateConfig as a Vim command
  vim.cmd "command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()"
  -- Allow yourself/register to run JdtBytecode as a Vim command
  vim.cmd "command! -buffer JdtBytecode lua require('jdtls').javap()"
  -- Allow yourself/register to run JdtShell as a Vim command
  vim.cmd "command! -buffer JdtJshell lua require('jdtls').jshell()"

  -- Set a Vim motion to <Space> + <Shift>J + o to organize imports in normal mode
  vim.keymap.set('n', '<leader>Jo', "<Cmd> lua require('jdtls').organize_imports()<CR>", { desc = '[J]ava [O]rganize Imports' })
  -- Set a Vim motion to <Space> + <Shift>J + v to extract the code under the cursor to a variable
  vim.keymap.set('n', '<leader>Jv', "<Cmd> lua require('jdtls').extract_variable()<CR>", { desc = '[J]ava Extract [V]ariable' })
  -- Set a Vim motion to <Space> + <Shift>J + v to extract the code selected in visual mode to a variable
  vim.keymap.set('v', '<leader>Jv', "<Esc><Cmd> lua require('jdtls').extract_variable(true)<CR>", { desc = '[J]ava Extract [V]ariable' })
  -- Set a Vim motion to <Space> + <Shift>J + <Shift>C to extract the code under the cursor to a static variable
  vim.keymap.set('n', '<leader>JC', "<Cmd> lua require('jdtls').extract_constant()<CR>", { desc = '[J]ava Extract [C]onstant' })
  -- Set a Vim motion to <Space> + <Shift>J + <Shift>C to extract the code selected in visual mode to a static variable
  vim.keymap.set('v', '<leader>JC', "<Esc><Cmd> lua require('jdtls').extract_constant(true)<CR>", { desc = '[J]ava Extract [C]onstant' })
  -- Set a Vim motion to <Space> + <Shift>J + t to run the test method currently under the cursor
  vim.keymap.set('n', '<leader>Jt', "<Cmd> lua require('jdtls').test_nearest_method()<CR>", { desc = '[J]ava [T]est Method' })
  -- Set a Vim motion to <Space> + <Shift>J + t to run the test method that is currently selected in visual mode
  vim.keymap.set('v', '<leader>Jt', "<Esc><Cmd> lua require('jdtls').test_nearest_method(true)<CR>", { desc = '[J]ava [T]est Method' })
  -- Set a Vim motion to <Space> + <Shift>J + <Shift>T to run an entire test suite (class)
  vim.keymap.set('n', '<leader>JT', "<Cmd> lua require('jdtls').test_class()<CR>", { desc = '[J]ava [T]est Class' })
  -- Set a Vim motion to <Space> + <Shift>J + u to update the project configuration
  vim.keymap.set('n', '<leader>Ju', '<Cmd> JdtUpdateConfig<CR>', { desc = '[J]ava [U]pdate Config' })
end

local function setup_jdtls()
  -- Get access to the jdtls plugin and all of its functionality
  local jdtls = require 'jdtls'

  -- Get the paths to the jdtls jar, operating specific configuration directory, and lombok jar
  local launcher, os_config, lombok = get_jdtls()

  -- Get the path you specified to hold project information
  local workspace_dir = get_workspace()

  -- Determine the root directory of the project by looking for these specific markers
  local root_dir = jdtls.setup.find_root { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle', 'build.gradle.kts' }

  -- Bring in blink cmp features
  -- local capabilities = vim.tbl_extend('force', { workspace = { configuration = true } }, require('blink.cmp').get_lsp_capabilities())
  local capabilities = require('blink.cmp').get_lsp_capabilities()

  -- Get the default extended client capablities of the JDTLS language server
  local extendedClientCapabilities = jdtls.extendedClientCapabilities
  -- Modify one property called resolveAdditionalTextEditsSupport and set it to true
  extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

  -- Set the command that starts the JDTLS language server jar
  local cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    -- '--enable-native-access=ALL-UNNAMED',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-javaagent:' .. lombok,
    '-jar',
    launcher,
    '-configuration',
    os_config,
    '-data',
    workspace_dir,
  }

  -- Configure settings in the JDTLS server
  local settings = {
    java = {
      classPath = {
        -- Add paths to your desired classpath entries here
        -- vim.fn.getcwd() .. '/libs/mwave_sdk.jar',
        '/libs/mwave_sdk.jar',
      },
      -- Enable code formatting
      format = {
        enabled = true,
        -- Use the Google Style guide for code formattingh
        -- settings = {
        --   url = "https://github.com/google/styleguide/blob/gh-pages/intellij-java-google-style.xml",
        --   profile = "GoogleStyle",
        -- },
      },
      -- Enable downloading archives from eclipse automatically
      eclipse = {
        downloadSource = true,
      },
      -- Enable downloading archives from maven automatically
      maven = {
        downloadSources = true,
      },
      -- Enable method signature help
      signatureHelp = {
        enabled = true,
      },
      -- Use the fernflower decompiler when using the javap command to decompile byte code back to java code
      contentProvider = {
        preferred = 'fernflower',
      },
      -- Setup automatical package import oranization on file save
      saveActions = {
        organizeImports = true,
      },
      -- Customize completion options
      completion = {
        -- When using an unimported static method, how should the LSP rank possible places to import the static method from
        favoriteStaticMembers = {
          'org.hamcrest.MatcherAssert.assertThat',
          'org.hamcrest.Matchers.*',
          'org.hamcrest.CoreMatchers.*',
          'org.junit.jupiter.api.Assertions.*',
          'java.util.Objects.requireNonNull',
          'java.util.Objects.requireNonNullElse',
          'org.mockito.Mockito.*',
        },
        -- Try not to suggest imports from these packages in the code action window
        filteredTypes = {
          'com.sun.*',
          'io.micrometer.shaded.*',
          'java.awt.*',
          'jdk.*',
          'sun.*',
        },
        -- Set the order in which the language server should organize imports
        importOrder = {
          'java',
          'jakarta',
          'javax',
          'com',
          'org',
        },
      },
      sources = {
        -- How many classes from a specific package should be imported before automatic imports combine them all into a single import
        organizeImports = {
          starThreshold = 9999,
          staticThreshold = 9999,
        },
      },
      -- How should different pieces of code be generated?
      codeGeneration = {
        -- When generating toString use a json format
        toString = {
          template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
        },
        -- When generating hashCode and equals methods use the java 7 objects method
        hashCodeEquals = {
          useJava7Objects = true,
        },
        -- When generating code use code blocks
        useBlocks = true,
      },
      imports = {
        gradle = {
          wrapper = {
            checksums = {
              {
                sha256 = '7d3a4ac4de1c32b59bc6a4eb8ecb8e612ccd0cf1ae1e99f66902da64df296172',
                allowed = true,
              },
            },
          },
        },
      },
      -- If changes to the project will require the developer to update the projects configuration advise the developer before accepting the change
      configuration = {
        updateBuildConfiguration = 'interactive',
        -- The runtimes' name parameter needs to match a specific Java execution environments.  See https://github.com/eclipse-jdtls/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request and search "ExecutionEnvironment".
        -- runtimes = {
        --   {
        --     name = 'JavaSE-24',
        --     path = '/Library/Java/JavaVirtualMachines/jdk-24.jdk',
        --   },
        -- },
      },
      -- enable code lens in the lsp
      referencesCodeLens = {
        enabled = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      -- enable inlay hints for parameter names,
      inlayHints = {
        parameterNames = {
          enabled = 'all',
        },
      },
    },
  }

  -- Create a table called init_options to pass the bundles with debug and testing jar, along with the extended client capablies to the start or attach function of JDTLS
  local init_options = {
    extendedClientCapabilities = extendedClientCapabilities,
    settings = settings,
  }

  -- Function that will be ran once the language server is attached
  local on_attach = function()
    -- Map the Java specific key mappings once the server is attached
    java_keymaps()

    -- Enable jdtls commands to be used in Neovim
    -- require('jdtls.setup').add_commands()

    -- Refresh the codelens
    -- Code lens enables features such as code reference counts, implemenation counts, and more.
    vim.lsp.codelens.refresh()

    -- Setup a function that automatically runs every time a java file is saved to refresh the code lens
    vim.api.nvim_create_autocmd('BufWritePost', {
      pattern = { '*.java' },
      callback = function()
        local _, _ = pcall(vim.lsp.codelens.refresh)
      end,
    })
  end

  local on_init = function(client, _)
    client.notify('workspace/didChangeConfiguration', { settings = settings })
  end

  -- Create the configuration table for the start or attach function
  local config = {
    cmd = cmd,
    root_dir = root_dir,
    settings = settings,
    capabilities = capabilities,
    init_options = init_options,
    on_init = on_init,
    on_attach = on_attach,
    filetypes = { 'java' },
    flags = { allow_incremental_sync = true },
  }

  -- Start the JDTLS server
  require('jdtls').start_or_attach(config)
end

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Setup JDTLS',
  group = vim.api.nvim_create_augroup('ag__setup_jdtls', { clear = true }),
  pattern = 'java',
  callback = function()
    setup_jdtls()
  end,
})
