<?php

namespace App\Http\Controllers;

use App\Models\Route;
use App\Models\RouteStop;
use Illuminate\Http\Request;

class RouteController extends Controller
{
    public function updateRoute(Request $request)
    {
        $validated = $request->validate([
            'route_id' => 'required|integer|exists:routes,id',
            'stops' => 'required|array|min:2',
            'stops.*.id' => 'required|integer',
            'stops.*.minutesFromStart' => 'required|integer',
            'startArrival' => 'required|date_format:H:i:s',
            'direction' => 'required|integer|in:0,1'
        ]);

        $route = Route::find($validated['route_id']);

        if (!$route) return response()->json([
            'message' => 'Заданный маршрут не найден'
        ]);

        RouteStop::where('route_id', $route->id)
            ->where('direction', $validated['direction'])
            ->delete();

        $stops = collect($validated['stops'])->map(function ($s, $idx) use ($route, $validated) {
            $arrival = new \DateTime($validated['startArrival']);

            return [
                'route_id' => $route->id,
                'stop_id' => $s['id'],
                'direction' => $validated['direction'],
                'position' => $idx,
                'arrival' => $arrival->add(new \DateInterval("PT{$s['minutesFromStart']}M"))
            ];
        });

        RouteStop::insert($stops->toArray());

        return response()->json([
            'message' => 'Маршрут обновлен'
        ]);
    }
}
