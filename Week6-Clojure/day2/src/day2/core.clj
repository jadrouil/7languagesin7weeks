(ns day2.core)

(defmacro unless [test body else]
    (list 'if (list 'not test) body else))

(defprotocol VendingMachine
    (dispense [c])
    (restock [c]))

(defrecord CokeVendingMachine [originalStock]
    VendingMachine
    (dispense [c] (CokeVendingMachine. (- originalStock 1)))
    (restock [c] (CokeVendingMachine. (+ originalStock 1))))
  
(defn -main []
    (assert (= 1 (unless false 1 2)))
    (assert (= 2 (unless true 1 2)))
    (println "done with macro\n")
    (def undertest (CokeVendingMachine. 3))
    (assert (= (:originalStock undertest) 3))
    (assert (= (:originalStock (dispense undertest)) 2))
    (assert (= (:originalStock (restock undertest)) 4))
    (println "done with VendingMachine protocol")

)