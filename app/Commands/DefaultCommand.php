<?php

namespace App\Commands;

use LaravelZero\Framework\Commands\AbstractCommand;

class DefaultCommand extends AbstractCommand
{
    /**
     * The name of the command.
     *
     * @var string
     */
    protected $name = 'default';

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

        $this->confirm('Confirm?');
        $this->ask('Ask Question?');

        //$shell = $this->getContainer()->make(\App\Modules\Utils\ShellCommand::class);
        //$shell->execute('ls -la');

        $nginx = $this->getContainer()->make(\App\Modules\Software\Nginx::class);
        //$nginx = new \App\Modules\Software\Nginx();
        $nginx->test();
    }
}
