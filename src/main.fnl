(var script {})

(set script.onStart
	(fn []
		;; Display some text
		(screen.setCenteredText "script started")

		;; Create some timers to show that the script is working
		(unit.setTimer "a" 2) ;; timer id "a", ticks every 2 seconds
		(unit.setTimer "b" 3) ;; timer id "b", ticks every 3 seconds
	)
)

(set script.onStop
	(fn []
		(screen.setCenteredText "script stopped")
	)
)

(set script.onActionStart
	(fn [actionName]
		(screen.setCenteredText (.. actionName " key pressed"))
	)
)

(set script.onActionStop
	(fn [actionName]
		(screen.setCenteredText (.. actionName " key released"))
	)
)

(set script.onTick
	(fn  [timerId]
		(screen.setCenteredText (.. "timer " timerId " ticked"))
	)
)

;; Other events that are available by default:
;; * onActionLoop(actionName): action key is held
;; * onUpdate(): executed once per frame
;; * onFlush(): executed 60 times per second, for physics calculations only; setEngineCommand must be called from here

;; Slot events are available if slot type is set with the ;;slot command line option.
(set script.onMouseDown
	(fn [x y]
		(screen.setCenteredText (.. "mouse down: x=" x " , y=" y))
	)
)

script