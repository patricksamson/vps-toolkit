<?php

namespace App\Modules\Software;

use App\Modules\Concerns\HasDependencies;
use App\Modules\Contracts\Installable;

abstract class AbstractGitCloneableSoftware extends AbstractBaseSoftware implements Installable
{
    use HasDependencies;

    protected $repository;
    protected $branch = 'master';
    protected $installPath;

    public function install()
    {
        $this->cloneRepository();
        $this->checkoutLatestTag();
        $this->installDependencies();
    }

    protected function cloneRepository()
    {
        `git clone {$this->repository} {$this->installPath} --branch {$this->branch} --single-branch --depth 1`;
    }

    protected function checkoutLatestTag()
    {
        // Fetch tags from origin, with minimal commit history
        `git fetch --depth=1 --tags {$this->installPath}`;

        // Get the tag of the latest release
        // TAG=$(git describe --tags $(git rev-list --tags --max-count=1))
        $tag = `git describe --tags $(git rev-list --tags --max-count=1)`;

        // Checkout the selected tag
        `git checkout -f tags/{$tag} {$this->installPath}`;
    }

    protected function installDependencies()
    {
        `composer install -d {$this->installPath}`;
    }

    public function remove()
    {
        `rm -rf {$this->installPath}`;
    }

    abstract public function getVersion(): string;

    public function isInstalled(): bool
    {
        return !empty(`which {$this->executable}`);
    }
}
