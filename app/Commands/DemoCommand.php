<?php

namespace App\Commands;

use LaravelZero\Framework\Commands\AbstractCommand;

class DemoCommand extends AbstractCommand
{
    /**
     * The name of the command.
     *
     * @var string
     */
    protected $name = 'test:demo';

    /**
     * The description of the command.
     *
     * @var string
     */
    protected $description = 'The demo app command';

    /**
     * Execute the console command. Here goes the command
     * code.
     */
    public function handle(): void
    {
        $this->info('Love beautiful code? We do too.');
        $this->notify('Hey Artisan', 'Enjoy the fresh air!');

        $name = $this->ask('What is your name?');
        $this->info("Hello, {$name}!");
    }
}
