<?php

return [
    /*
     * Here goes your console application configuration. You should
     * define your application list of commands and your Laravel
     * Service Providers configuration.
     */
    'app' => [
        /*
         * Here goes the application name.
         */
        'name' => 'VPS Toolkit',

        /*
         * Here goes the application version.
         */
        'version' => '1.0.0',

        /*
         * If true, development commands won't be available as the app
         * will be in the production environment.
         */
        'production' => false,

        /*
         * Here goes the application default command.
         *
         * You may want to remove this line in order to ask the user what command he
         * wants to execute.
         */
        'default-command' => App\Commands\DefaultCommand::class,

        /*
         * Here goes the application list of commands.
         *
         * Besides the default command the user can also call
         * any of the commands specified below.
         */
        'commands' => [
            App\Commands\DemoCommand::class,
        ],

        /*
         * Here goes the application list of Laravel Service Providers.
         * Enjoy all the power of Laravel on your console.
         */
        'providers' => [
            App\Providers\AppServiceProvider::class,
            \NunoMaduro\LaravelDesktopNotifier\LaravelDesktopNotifierServiceProvider::class,
        ],
    ],

    /*
     * Here goes the illuminate/database component configuration.
     *
     * @see https://github.com/laravel/laravel/blob/master/config/database.php
     *      in order to understand how to configure other drivers.
     */
    'database' => [
        'connections' => [
            'default' => [
                'driver' => 'sqlite',
                'database' => __DIR__.'/../database/database.sqlite',
            ],
        ],
    ],

    'modules' => [
        'Automysqlbackup' => \App\Modules\Software\Automysqlbackup::class,
        'BaseTools' => \App\Modules\Software\BaseTools::class,
        'Certbot' => \App\Modules\Software\Certbot::class,
        'MariaDB' => \App\Modules\Software\MariaDB::class,
        'Nginx' => \App\Modules\Software\Nginx::class,
        'NodeJS' => \App\Modules\Software\Nodejs::class,
        'PHP' => \App\Modules\Software\PHP::class,
        'PostgreSQL' => \App\Modules\Software\PostgreSQL::class,
        'Transmission' => \App\Modules\Software\Transmission::class,
    ],
];