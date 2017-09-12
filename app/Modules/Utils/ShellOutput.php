<?php

namespace App\Modules\Utils;

use Illuminate\Console\OutputStyle;
use Illuminate\Contracts\Support\Arrayable;
use Symfony\Component\Console\Helper\Table;
use Symfony\Component\Console\Input\ArgvInput;
use Symfony\Component\Console\Output\ConsoleOutput;
use Symfony\Component\Console\Output\OutputInterface;

class ShellOutput
{
    protected $output;

    public function __construct()
    {
        $this->output = new OutputStyle(new ArgvInput(), new ConsoleOutput());
    }

    public function execute($command)
    {
        $this->printCommand($command);

        $this->output->confirm('OK?', false);

        system($command);
    }

    public function printCommand($string, $verbosity = null)
    {
        $this->line($string, 'question', $verbosity);
    }

    /**
     * Write a string as standard output.
     *
     * @param string          $string
     * @param string          $style
     * @param null|int|string $verbosity
     */
    public function line($string, $style = null, $verbosity = null)
    {
        $styled = $style ? "<$style>$string</$style>" : $string;

        $this->output->writeln($styled, OutputInterface::VERBOSITY_NORMAL);
    }

    /**
     * Format input to textual table.
     *
     * @param array                                         $headers
     * @param \Illuminate\Contracts\Support\Arrayable|array $rows
     * @param string                                        $style
     */
    public function table($headers, $rows, $style = 'default')
    {
        $table = new Table($this->output);

        if ($rows instanceof Arrayable) {
            $rows = $rows->toArray();
        }

        $table->setHeaders((array) $headers)->setRows($rows)->setStyle($style)->render();
    }
}
