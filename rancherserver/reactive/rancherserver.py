from charms.docker.compose import Compose
from charms.docker.dockeropts import DockerOpts

from charms.reactive import when
from charms.reactive import when_not

from charmhelpers.core.hookenv import config
from charmhelpers.core.hookenv import status_set
from charmhelpers.core.templating import render

@when('docker.available')
def run_rancherserver():
    # Render teh template
   cfg = config()
   render('docker-compose.yml', 'files/rancherserver/docker-compose.yml', cfg)

   comp = Compose('files/rancherserver')
   comp.up()

@when('docker.ready')
def configure_docker():
  manager = DockerOpts()
  render('docker.defaults', '/etc/default/docker', {'opts': manager.to_s()})
