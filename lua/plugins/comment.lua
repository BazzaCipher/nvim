-- Allow easy commenting
return {
	'numToStr/Comment.nvim',
	keys = { "g" },

	config = function()
		require('Comment').setup()
	end,
}
