(ns cljboot.core-test
  (:require [cljboot.core :as sut]
            [clojure.test :as t]))

(t/deftest basic-tests
  (t/testing "it says hello to everyone"
    (t/is (= (with-out-str (sut/-main)) "hello world\n"))))
