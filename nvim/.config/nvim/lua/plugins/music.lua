if vim.fn.has 'mac' then
  return {}
else
  return {
    'AntonVanAssche/music-controls.nvim',
    opts = {
      default_player = 'spotify',
    },
  }
end
