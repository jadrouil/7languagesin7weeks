(ns day3.core)
;;use individual refs for account. No need to block account 1 just cause account 2 is in use.
(def accounts (vector (ref 100.00) (ref 400.00)  (ref 200.00)))

(defn deposit
  "Deposits n into account"
  [account, n]
  (dosync (alter account +  n))
)

(defn withdraw
  "withdraws n from account"
  [account, n]
  (dosync (alter account -  n))
)

;;part 2 

;;for some reason the clients sends aren't registering on the barber?
;;it may have something to do with being inside the do or dosync
(def waitingRoom (ref 0)) 

(defn cuthair
    "instructs barber to cut hair"
    [x]
    (do
        (dosync (alter waitingRoom - 1))
        (Thread/sleep 20)
        (+ x 1)
    )
)   




(defn addClient
    "adds client to waitingRoom if possible for barber b"
    [b]
    (if (< @waitingRoom 3)
        (do
            (dosync (alter waitingRoom + 1))
            (send-off b cuthair)
            (release-pending-sends) ;;super duper important -- clojure agents won't send messages to other agents until the end of the agent's execution. Unless, of course, you explicitly release the messages.
        )
    )
)

(defn spawnClients
    "continously spawns clients with random sleep for n milliseconds, b is the barber "
    [n, b]
    (let []
        (loop [totalTimePassed 0]
            (let [randomPause (+ (rand-int 21) 10)]
                (if (< (+ totalTimePassed randomPause) n)
                    (do
                        (Thread/sleep randomPause)
                        (addClient b)
                        (recur (+ totalTimePassed randomPause))
                    )
                )
            )
        )
    )
)
    



(defn runHaircutSimulation 
    "runs haircut simulator for n seconds"
    [n]
    (def barber (agent 0))
    (def clientSpawner (delay (spawnClients (* n 1000) barber) @barber))
    (println (str "Haircuts given: " @clientSpawner ))
    
    (shutdown-agents)
)



(defn -main []
    (deposit (get accounts 0) 20.0)
    (assert (= (deref (get accounts 0)) 120.00))
    (withdraw (get accounts 0) 100.00)
    (assert (=  (deref (get accounts 0)) 20.00))
    (println "done with part 1")
    
    (runHaircutSimulation 10)
    
    
)