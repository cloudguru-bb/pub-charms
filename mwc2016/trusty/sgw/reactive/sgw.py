from charms.docker.compose import Compose

from charms.reactive import when
from charms.reactive import when_not
from charms.reactive import set_state

from charmhelpers.core.hookenv import config
from charmhelpers.core.hookenv import status_set
from charmhelpers.core.templating import render

from charms.docker import Docker


@when_not('sgw.configured')
def check_configuration():
    required_keys = ['distribution-user',
                     'distribution-pass',
                     'distribution-email']
    for k in required_keys:
        if not config(k):
            status_set("blocked", "Missing config option {}".format(k))
            return
    status_set('active', '')
    set_state('sgw.configured')


@when('docker.available', 'sgw.configured')
def run_sgw():
    # authenticate to private docker repository
    d = Docker()
    cfg = config()
    d.login(cfg['distribution-user'], cfg['distribution-pass'],
            cfg['distribution-email'])

    # Render the template
    render('docker-compose.yml', 'files/sgw/docker-compose.yml', cfg)

    comp = Compose('files/sgw')
    comp.up()
