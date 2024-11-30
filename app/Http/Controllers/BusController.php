<?php

namespace App\Http\Controllers;

use App\Models\Route;
use App\Models\RouteStop;
use App\Models\Stop;
use Illuminate\Http\Request;

class BusController extends Controller
{
    public function __invoke(Request $request)
    {
        $from = (int) $request->input('from');
        $to = (int) $request->input('to');

        if (!$from || !$to) {
            return response()->json(['error' => "Missing 'from' and 'to' parameters"], 400);
        }

        $fromStop = Stop::find($from);

        if (!$fromStop) {
            return response()->json(['error' => "Specified start stop does not exist"], 400);
        }

        $toStop = Stop::find($to);

        if (!$toStop) {
            return response()->json(['error' => "Specified target stop does not exist"], 400);
        }

        $direction = $from < $to ? 0 : 1;
        $routes = Route::whereHas('stops', function ($q) use ($from, $to, $direction) {
            $q->whereIn('stop_id', [$from, $to])
                ->where('direction', $direction);
        })->get();

        $response = [
            'from' => $fromStop->name,
            'to' => $toStop->name,
            'buses' => $routes->map(function ($r) use ($from, $to, $direction) {
                $stops = RouteStop::where('route_id', $r->id)
                    ->where('direction', $direction)
                    ->whereIn('stop_id', [$from, $to])
                    ->orderBy('position')
                    ->get();

                $fromStop = $stops->firstWhere('stop_id', $from);
                $toStop = $stops->firstWhere('stop_id', $to);

                if (!$fromStop || !$toStop || $fromStop->position >= $toStop->position) return null;

                $nextArrivals = RouteStop::where('route_id', $r->id)
                    ->where('stop_id', $from)
                    ->where('direction', $direction)
                    ->where('arrival', '>=', now()->format('H:i:s'))
                    ->orderBy('arrival')
                    ->get()
                    ->map(fn($rs) => substr($rs->arrival, 0, 5));

                if ($nextArrivals->isEmpty()) return null;

                $lastStop = $direction === 0 ? $r->endStop : $r->beginStop;

                return [
                    'route' => "{$r->name} в сторону {$lastStop->name}",
                    'next_arrivals' => $nextArrivals,
                ];
            })->filter()->values()
        ];

        return response()->json($response);
    }
}
