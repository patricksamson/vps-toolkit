<?php

namespace App\Modules\Software;

use App\Modules\Concerns\HasDependencies;
use App\Modules\Contracts\Installable;

abstract class AbstractAptGetSoftware extends AbstractBaseSoftware implements Installable
{
    use HasDependencies;

    /**
     * The PPA Repository to add.
     * add-apt-repository ppa:{repository}.
     *
     * @var string
     */
    protected $repository;

    /**
     * The packages to install.
     * apt-get install {packages}.
     *
     * @var array
     */
    protected $packages = [];

    /**
     * Once the software is installed, what is it's executable?
     * EX : nginx, mysql, php...
     *
     * @var string
     */
    protected $executable;

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
