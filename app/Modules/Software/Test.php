<?php

namespace App\Modules\Software;

use App\Modules\Concerns\CopiesConfigurationFiles;
use App\Modules\Concerns\ExecutesShellCommands;
use App\Modules\Contracts\Installable;
use Illuminate\Support\Facades\Storage;

class Test extends AbstractBaseSoftware implements Installable
{
    use CopiesConfigurationFiles, ExecutesShellCommands;

    protected $name = 'Test';
    protected $description = 'Experiments';

    public function install()
    {
        $config = Storage::get('transmission-settings.json');

        $replaceFrom = ['USER_NAME', 'WEBUI_USERNAME', 'WEBUI_PASSWORD'];
        $replaceTo = ['psamson', 'Lykegenes', 'hunter2'];

        $this->execute('php vps-toolkit software:install');
    }

    public function remove()
    {
    }

    public function getVersion(): string
    {
        return '123';
    }

    public function isInstalled(): bool
    {
        return true;
    }
}
