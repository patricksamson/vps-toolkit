<?php

namespace App\Modules\Software;

use App\Modules\Concerns\ExecutesShellCommands;
use App\Modules\Concerns\HasDependencies;
use App\Modules\Contracts\Installable;

class Composer extends AbstractBaseSoftware implements Installable
{
    use HasDependencies, ExecutesShellCommands;

    protected $name = 'Composer';
    protected $description = 'Composer is a tool for dependency management in PHP';

    protected $executable = 'composer';
    protected $installPath = '/usr/local/bin/composer';

    protected $dependencies = [
        PHP::class,
    ];

    public function install()
    {
        $this->execute('curl -sS https://getcomposer.org/installer | php');
        $this->execute("sudo mv composer.phar ${$this->installPath}");
    }

    public function remove()
    {
        `rm {$this->installPath}`;
    }

    public function isInstalled(): bool
    {
        return !empty(`which {$this->executable}`);
    }

    public function getVersion(): string
    {
        return `{$this->executable} -V`;
    }
}
