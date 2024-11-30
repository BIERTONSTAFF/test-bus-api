<?php

use App\Http\Controllers\BusController;
use App\Http\Controllers\RouteController;
use Illuminate\Support\Facades\Route;

Route::get('/find-bus', BusController::class);
Route::put('/routes', [RouteController::class, 'updateRoute']);