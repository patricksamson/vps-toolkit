<?php

namespace App\Modules\Software;

use App\Modules\Concerns\CopiesConfigurationFiles;
use App\Modules\Concerns\HasDependencies;
use App\Modules\Concerns\HasService;

class Transmission extends AbstractAptGetSoftware
{
    use HasService, HasDependencies, CopiesConfigurationFiles;

    protected $name = 'Transmission';
    protected $description = '';

    protected $repository = 'transmissionbt/ppa';

    protected $packages = [
        'transmission-cli',
        'transmission-common',
        'transmission-daemon',
    ];

    protected $executable = 'transmission-daemon';
    protected $service = 'transmission-daemon';

    protected $dependencies = [Nginx::class];

    public function install()
    {
        parent::install();

        $replaceFrom = ['USER_NAME', 'WEB_USERNAME', 'WEB_PASSWORD', 'TRANSMISSION_SERVER_NAME', 'DOWNLOADS_SERVER_NAME'];

        $replaceTo[] = $this->ask('Enter the user name where the files will be located.');
        $replaceTo[] = $TUNAME = $this->ask('Enter the Transmission Web UI username.');
        $replaceTo[] = $TPASS = $this->secret('Enter the Transmission Web UI password.');
        $replaceTo[] = $this->ask('Enter the Transmission Web UI domain name.');
        $replaceTo[] = $this->ask('Enter the Downloads page domain name.');

        // Copy the Transmission settings
        $this->copyConfigurationFile(
            'transmission-settings.json',
            '/var/lib/transmission-daemon/info/settings.json',
            $replaceFrom,
            $replaceTo
        );

        // Copy the Nginx config for the Transmission Web UI
        $this->copyConfigurationFile(
            'transmission-nginx-proxy',
            '/etc/nginx/sites-enabled/transmission-proxy',
            $replaceFrom,
            $replaceTo
        );

        // Copy the Nginx config for the HTTP Downloads
        $this->copyConfigurationFile(
            'transmission-nginx-downloads',
            '/etc/nginx/sites-enabled/transmission-downloads',
            $replaceFrom,
            $replaceTo
        );

        // TODO : Create basic auth password file
        `sudo sh -c "echo -n 'sammy:' >> /etc/nginx/conf.d/transmission-downloads.htpasswd"`;
        `sudo sh -c "openssl passwd -apr1 >> /etc/nginx/conf.d/transmission-downloads.htpasswd"`;

        // TODO : reload nginx config
        `sudo nginx -s reload`;

        // Update transmission bloacklist
        `transmission-remote --auth {$TUNAME}:{$TPASS} --blocklist-update`;
    }

    public function getVersion(): string
    {
        return ''.`transmission-daemon -V`;
    }
}
