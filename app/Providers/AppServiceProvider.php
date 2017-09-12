<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap any application services.
     */
    public function boot()
    {
        $this->app->singleton(\App\Modules\Utils\ShellCommand::class, function ($app) {
            return new \App\Modules\Utils\ShellCommand();
        });
    }

    /**
     * Register any application services.
     */
    public function register()
    {
    }
}
