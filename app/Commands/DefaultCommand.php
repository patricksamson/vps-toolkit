<?php

namespace App\Commands;

use Illuminate\Support\Collection;
use LaravelZero\Framework\Commands\Command;

class DefaultCommand extends Command
{
    /**
     * The name of the command.
     *
     * @var string
     */
    protected $name = 'software:install';

    /**
     * The description of the command.
     *
     * @var string
     */
    protected $description = 'The default app command';

    /**
     * Execute the console command. Here goes the command
     * code.
     */
    public function handle(): void
    {
        $this->line('Line');
        $this->info('Info');
        $this->comment('Comment');
        $this->question('Question');
        $this->error('Error');
        $this->warn('Warn');
        $this->alert('Alert');

        //$this->confirm('Confirm?');
        //$this->ask('Ask Question?');

        //$shell = $this->getContainer()->make(\App\Modules\Utils\ShellCommand::class);
        //$shell->execute('ls -la');

        $nginx = $this->getContainer()->make(\App\Modules\Software\Nginx::class);
        //$nginx = new \App\Modules\Software\Nginx();

        $this->info($nginx->getVersion());

        //$modules = config('modules');
        $modules = new Collection();
        foreach (config('modules.enabled') as $moduleClass) {
            $instance = $this->getContainer()->make($moduleClass);
            $modules->put($instance->getKey(), $instance);
        }

        $headers = ['Name', 'Installed?', 'Description'];
        $modulesAutocomplete = [];
        foreach ($modules as $module) {
            $modulesAutocomplete[] = $module->getName();
            $modulesAutocomplete[] = strtolower($module->getName());
        }
        $rows = $modules->map(function ($module) {
            return [
                'name' => $module->getName(),
                'installed' => $module->isInstalled() ? '✔ Yes' : '✘ No',
                'description' => $module->getDescription() ?? '',
            ];
        });

        $this->table($headers, $rows);

        $moduleKey = $this->anticipate('Choose a program', $modulesAutocomplete);

        $moduleInstance = $modules->get(strtolower($moduleKey));
        $moduleInstance->install();
        $this->info($moduleInstance->isInstalled() ? 'installed' : 'not found');
        $this->line($moduleInstance->getVersion());
    }
}
