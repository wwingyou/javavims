return {
  'wwingyou/telescope_docker',
  config = function ()
    local docker = require'telescope-docker'
    vim.keymap.set('n', '<leader>oi', docker.view_docker_images, { desc = 'Docker Show Images'})
    vim.keymap.set('n', '<leader>oc', docker.view_docker_containers, { desc = 'Docker Show Containers' })
  end
}
