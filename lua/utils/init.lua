local utils = {}

vim.cmd("noremap -eu :e ~/.config/nvim/lua/utils/init.lua<CR>")

function utils.set_global_option(key,value)
    vim.o[key] = value
end

function utils.buffer_modified()
    return vim.bo.modified
end

function utils.get_buffer_dir()
  return vim.call("expand","%:h")
end

function utils.term_in_cur_file_dir()
  local buffer_dir = utils.get_buffer_dir()
  utils.change_window_pwd_to(buffer_dir)
  utils.term_open()
end

function utils.change_window_pwd_to(dir)
  vim.cmd(string.format("lcd %s",dir))
end

function utils.term_open()
  vim.cmd("terminal")
end

function utils.get_bufnr()
  return vim.fn.bufnr()
end

function utils.cursor_get_pos()
	local pos = vim.fn.getcurpos()
	return {row=pos[2], col=pos[3]}
end

function utils.insert_to_cur_pos(textArray)
  vim.api.nvim_put(textArray,"l",false,false)
end


return utils
