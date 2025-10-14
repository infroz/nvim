-- Typescript Language Server

return {
	on_attach = function(client, bufnr)
		local set = vim.keymap.set

		local root_dir = client.config.root_dir
		-- NX Workspace
		if vim.fn.filereadable(root_dir .. "/nx.json") then
			local opts = {
				output_style = "--output-style=static", -- use either stream or static to avoid cli UI
			}

			function nx(cmd)
				local cmd_formatted = string.format("nx %s --output-style=static", cmd)
				vim.fn.system(cmd_formatted)
			end

			local current_file = vim.api.nvim_buf_get_name(0)
			-- current file is app if it matches **/apps/*app_name*/**
			-- current file is lib if it matches **/libs/*lib_name*/**
			local app_name = current_file:match("apps/([^/]+)")
			local lib_name = current_file:match("libs/([^/]+)")

			if app_name then
				-- for debug
				vim.notify("Loaded app " .. app_name, vim.log.levels.INFO, { title = "NX Workspace" })
				-- before we enable serve, we want to create some custom buffer for it to output to
				-- set('n', '<leader>na', ':!nx serve ' .. is_app .. ' --skip-nx-cache --verbose<CR>', opts)
				-- build and output errors to quickfix
				function build_app()
					local cmd =
							string.format("nx build %s --skip-nx-cache --output-style=errors-warnings --verbose", app_name)
					-- Set the quickfix list from the command's output
					-- This is a more robust way than piping through sed/awk/tee
					vim.notify("Running: " .. cmd, vim.log.levels.INFO, { title = "NX Build" })
					local output = vim.fn.system(cmd)
					vim.fn.setqflist({}, "r", { title = "Nx Build: " .. app_name, lines = vim.split(output, "\n") })
					vim.cmd("copen")
					vim.notify("Nx build for [" .. app_name .. "] complete.", vim.log.levels.INFO)
				end

				function test_app()
					local cmd = string.format("nx vitest %s --skip-nx-cache --verbose", app_name)
					vim.notify("Running: " .. cmd, vim.log.levels.INFO, { title = "NX Test" })
					local output = vim.fn.system(cmd)
					vim.fn.setqflist({}, "r", { title = "Nx Test: " .. app_name, lines = vim.split(output, "\n") })
					-- Open the quickfix window to show test results
					vim.cmd("copen")
					vim.notify("Nx test for [" .. app_name .. "] complete.", vim.log.levels.INFO)
				end

				function deploy_preview()
					local confirm = vim.fn.input("Are you sure you want to deploy a preview? (y/n): ")
					if confirm:lower() ~= "y" then
						vim.notify("Deployment cancelled.", vim.log.levels.WARN)
						return
					end
					local env = vim.fn.input("Environment (dev | test | prod): ")
					local allowed_envs = { "dev", "test", "prod" }
					if not vim.tbl_contains(allowed_envs, env) then
						vim.notify("Invalid environment. Allowed: dev, test, prod.", vim.log.levels.ERROR)
						return
					end
					vim.notify(string.format("Deploying %s to %s environment...", app_name, env))
					nx(string.format("deploy %s --env=%s", app_name, env))
					vim.notify("Nx deploy for [" .. app_name .. "] to [" .. env .. "] complete.", vim.log.levels.INFO)
				end

				set("n", "<leader>np", deploy_preview, { desc = "[NX] Deploy Preview " .. app_name })
				set("n", "<leader>nb", build_app, { desc = "[NX] Build " .. app_name })
			end
		end
	end,
}
