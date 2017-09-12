<?php

namespace App\Modules\Software;

use App\Modules\Concerns\HasDependencies;
use App\Modules\Contracts\Installable;
use App\Modules\Utils\ShellOutput;

abstract class AbstractAptGetSoftware implements Installable
{
    use HasDependencies;

    protected $ouptut;
    protected $repository;
    protected $packages = [];
    protected $executable;

    public function __construct(ShellOutput $ouptut)
    {
        $this->output = $ouptut;
    }

    public function install()
    {
        $this->addAptRepository();
        $this->refreshPackages();
        $this->executeInstall();
    }

    public function remove()
    {
        /**
         * apt-get remove : Remove the software, but keep the configuration files.
         * apt-get purge  : Also delete the configuration files.
         */
        $packagesList = implode(' ', $this->packages);
        $output = `sudo apt-get remove {$packagesList}`;
    }

    protected function addAptRepository()
    {
        if (!empty($this->repository)) {
            // Is this repository already in our sources?
            $found = `grep ^ /etc/apt/sources.list /etc/apt/sources.list.d/* | grep {$this->repository}`;

            if (empty($found)) {
                $output = `sudo add-apt-repository -y ppa:{$this->repository}`;
            }
        }
    }

    private function refreshPackages()
    {
        $output = `sudo apt-get update`;
    }

    private function executeInstall()
    {
        $packagesList = implode(' ', $this->packages);
        $output = `sudo apt-get -y install $packagesList`;
    }

    abstract public function getVersion(): string;

    public function isInstalled(): bool
    {
        return !empty(`which {$this->executable}`);
    }
}
