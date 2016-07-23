(ns day1.core)

(defn foo
  "I don't do a whole lot."
  [x]
  (println x "Hello, World!"))

(defn big
  "I take a string and a number. Then I return if it is longer than the number characters."
  [st, n]
  (> (count st) n)
)

(defn collection-type
  "Returns a keyword based off of the collection type passed in"
  [col]
  (def typeMapping {clojure.lang.PersistentArrayMap :map,
		    clojure.lang.PersistentVector :vector,
		    clojure.lang.PersistentList :list,
		    clojure.lang.PersistentList$EmptyList :list})
  (typeMapping (class col))
)

(defn -main []
	(assert (=  (big "" 1) false))
	(assert (big "to" 1))
	(println "done with big\n")
	(assert (= (collection-type []) :vector))
	(assert (= (collection-type '(1)) :list))
	(assert (= (collection-type {}) :map))
	(assert (= (collection-type '()) :list))
	(println "done with col type")
)
