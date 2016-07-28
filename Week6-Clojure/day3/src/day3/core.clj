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

(comment 
            (def waitingRoom (ref 0)) ;;waitingRoom initialized to zero 
            (defn attemptAddToWaitingRoom
                "attempts to add a customer to the waitingRoom"
                []
                (dosync (if (< @waitingRoom 3) 
                            (alter waitingRoom + 1)))
            )

            (defn attemptTakeFromWaitingRoom
                "moves client from waitingRoom"
                []
                (dosync (if (> @waitingRoom 0)
                            (alter waitingRoom - 1)))
            )
)
(defn getWaiter [wR]
    (do (if (not (empty wR)) (pop wR))))
(defn addWaiter  [wR]
    (if (< (count wR) 3) (conj wR true))
)

(defn runHairCutSimulator 
    "runs the part2 haircut simulator"
    []
    (def haircutsGiven (atom 0))
    (def waitingRoom (agent [])) 
    
)


(defn -main []
    (deposit (get accounts 0) 20.0)
    (assert (= (deref (get accounts 0)) 120.00))
    (withdraw (get accounts 0) 100.00)
    (assert (=  (deref (get accounts 0)) 20.00))
    (println "done with part 1")
    
    (comment
        (attemptTakeFromWaitingRoom)
        (assert (= @waitingRoom 0))
        (attemptAddToWaitingRoom)
        (assert (= @waitingRoom 1))
        (attemptAddToWaitingRoom)
        (assert (= @waitingRoom 2))
        (attemptAddToWaitingRoom)
        (assert (= @waitingRoom 3))
        (attemptAddToWaitingRoom)
        (assert (= @waitingRoom 3))
        (attemptTakeFromWaitingRoom)
        (assert (= @waitingRoom 2))
    )
    (println "barbershop waitingRoom fills/empties correctly")
    (runHairCutSimulator)
    (println (str "number of haircuts given: " @haircutsGiven))
    
)