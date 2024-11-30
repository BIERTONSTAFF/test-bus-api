<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Route extends Model
{
    protected $table = 'routes';

    public function stops()
    {
        return $this->hasMany(RouteStop::class);
    }

    public function beginStop()
    {
        return $this->belongsTo(Stop::class, 'begin_stop_id');
    }

    public function endStop()
    {
        return $this->belongsTo(Stop::class, 'end_stop_id');
    }
}
