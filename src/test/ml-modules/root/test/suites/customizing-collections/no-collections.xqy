xquery version "1.0-ml";

(:
 : Verify that the collection names in the merge options are being used.
 :)

import module namespace test = "http://marklogic.com/roxy/test-helper" at "/test/test-helper.xqy";
import module namespace lib = "http://marklogic.com/smart-mastering/test" at "lib/lib.xqy";

import module namespace matcher = "http://marklogic.com/smart-mastering/matcher"
  at "/com.marklogic.smart-mastering/matcher.xqy";

import module namespace merging = "http://marklogic.com/smart-mastering/merging"
  at "/com.marklogic.smart-mastering/merging.xqy";

import module namespace coll = "http://marklogic.com/smart-mastering/collections"
  at "/com.marklogic.smart-mastering/impl/collections.xqy";

import module namespace const = "http://marklogic.com/smart-mastering/constants"
  at "/com.marklogic.smart-mastering/constants.xqy";

let $match-options := matcher:get-options($lib:XML-MATCH-OPT-NAME-NO-COLL, $const:FORMAT-XML)
let $merge-options := merging:get-options($lib:XML-MERGE-OPT-NAME-NO-COLL, $const:FORMAT-XML)

let $assertions := (
  test:assert-not-exists(coll:content-collections($match-options)),
  test:assert-not-exists(coll:merged-collections($merge-options)),
  test:assert-not-exists(coll:archived-collections($merge-options)),
  test:assert-not-exists(coll:notification-collections($merge-options)),
  test:assert-not-exists(coll:auditing-collections($merge-options))
)

let $match-options := matcher:get-options($lib:JSON-MATCH-OPT-NAME-NO-COLL, $const:FORMAT-XML)
let $merge-options := merging:get-options($lib:JSON-MERGE-OPT-NAME-NO-COLL, $const:FORMAT-XML)

let $assertions := (
  $assertions,
  test:assert-not-exists(coll:content-collections($match-options)),
  test:assert-not-exists(coll:merged-collections($merge-options)),
  test:assert-not-exists(coll:archived-collections($merge-options)),
  test:assert-not-exists(coll:notification-collections($merge-options)),
  test:assert-not-exists(coll:auditing-collections($merge-options))
)

return $assertions
