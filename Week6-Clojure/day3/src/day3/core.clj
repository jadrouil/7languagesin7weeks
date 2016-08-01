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
(def waitingRoom (ref 0)) 

(defn cuthair
    "instructs barber to cut hair"
    [x]
    (do
        (println "cutting hair")
        (dosync (alter waitingRoom - 1))
        (Thread/sleep 20)
        (+ x 1)
    )
)   



(def clientSpawner (agent 0))
(def barber (agent 0))


(defn addClient
    "adds client to waitingRoom if possible for barber b"
    [b]
    (if (< @waitingRoom 3)
        (do
            (println "client adding")
            (dosync (alter waitingRoom + 1))
            (send b cuthair)
            (println (str (agent-error b)))
        )
    )
)

(defn spawnClients
    "continously spawns clients with random sleep for n seconds, b is the barber "
    [self, n, b]
    ;(dotimes [i (* n 1000)]  ;;n * 1000 is the maximum amount of clients to occur in n seconds
     ;   (do 
     ;       (Thread/sleep (+ (rand-int 21) 10)) ; max value is 20 + 10, min is 0 + 10 
     ;       (addClient b)
     ;   )
    ;)
    (send b cuthair)
)


(defn runHaircutSimulation 
    "runs haircut simulator for n seconds"
    [n]
    (send clientSpawner spawnClients n barber)
    (Thread/sleep (* n 1000))
    (println (str "Haircuts given: " @barber ))
)            



(defn -main []
    (deposit (get accounts 0) 20.0)
    (assert (= (deref (get accounts 0)) 120.00))
    (withdraw (get accounts 0) 100.00)
    (assert (=  (deref (get accounts 0)) 20.00))
    (println "done with part 1")
    
 ;   (send barber cuthair)
 ;   (await barber)
 ;   (assert (= @barber 1))
    (runHaircutSimulation 10)
    
    
    
)