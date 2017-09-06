<?php

namespace App\Modules\Software;

abstract class AbstractAptGetSoftware
{
    protected $repository;
    protected $packages = [];
    protected $executable;
    protected $service;

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
         * apt-get purge. : Also delete the configuration files.
         */
        $packagesList = implode(' ', $this->packages);
        $output = `sudo apt-get remove {$packagesList}`;
    }

    protected function addAptRepository()
    {
        if (!empty($this->repository)) {
            // Is this repository already in our sources?
            $found = `grep ^ /etc/apt/sources.list /etc/apt/sources.list.d/* | grep {$this->repository}`;

            if (!empty($found)) {
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

    public function hasService()
    {
        return $this->service != null;
    }

    public function startService()
    {
        if ($this->hasService()) {
            `sudo service {$this->service} start`;
        }
    }

    public function reloadService()
    {
        if ($this->hasService()) {
            `sudo service {$this->service} reload`;
        }
    }

    public function restartService()
    {
        if ($this->hasService()) {
            `sudo service {$this->service} restart`;
        }
    }

    public function stopService()
    {
        if ($this->hasService()) {
            `sudo service {$this->service} stop`;
        }
    }

    abstract public function getVersion();

    public function isInstalled(): bool
    {
        return !empty(`which {$this->executable}`);
    }
}
