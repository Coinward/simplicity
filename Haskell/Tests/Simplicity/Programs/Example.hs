-- A set of example Simplicity programs that can be used for tests, but otherwise are not expected to be useful.
module Simplicity.Programs.Example
  ( fib
  ) where

import Prelude hiding (drop)
import Simplicity.Programs.Bit
import Simplicity.Programs.Generic
import Simplicity.Programs.Loop
import Simplicity.Programs.Word
import Simplicity.Term.Core

-- | An example program that uses disconnect via the 'loop' construction.
-- @'fib' (3,(1,0))@ will compute the 2^4, or 16th Fibonacci number
fib :: (Delegate term, Assert term) => term (Word2, (Word16, Word16)) Word16
fib = loopDepth 4 ((zero word2 &&& oh >>> eq) &&& ((oh &&& scribe (toWord2 1) >>> subtractor word2 >>> ih) &&& drop (iden &&& iden >>> step)) >>> cond (injr ioh) (injl iden))
 where
  add = adder word16 >>> ih;
  mul = multiplier word16 >>> ih;
  step = ((ooh &&& ioh >>> mul) &&& (ooh &&& iih >>> mul)) &&& ((oih &&& ioh >>> mul) &&& (oih &&& iih >>> mul)) >>> (ooh &&& (ioh &&& oih >>> add) >>> add) &&& (ooh &&& iih >>> add)
