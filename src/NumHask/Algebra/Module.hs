{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE RebindableSyntax #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# OPTIONS_GHC -Wall #-}

-- | Algebra for Modules
module NumHask.Algebra.Module
  ( AdditiveAction (..),
    SubtractiveAction (..),
    MultiplicativeAction (..),
    DivisiveAction (..),
    Module,
  )
where

import NumHask.Algebra.Ring
import NumHask.Algebra.Additive
import NumHask.Algebra.Multiplicative

-- $setup
--
-- >>> :set -XRebindableSyntax
-- >>> :set -XNegativeLiterals
-- >>> :set -XFlexibleContexts
-- >>> :set -XFlexibleInstances
-- >>> :set -XScopedTypeVariables
-- >>> :set -XMultiParamTypeClasses
-- >>> import NumHask.Prelude
-- >>> import Test.QuickCheck
-- >>> import Prelude (Int, fmap)

-- | Additive Action
--
class
  (Additive a) =>
  AdditiveAction m a | m -> a where
  infixl 6 .+
  (.+) :: a -> m -> m

  infixl 6 +.
  (+.) :: m -> a -> m

-- | Subtractive Action
--
class
  (Subtractive a) =>
  SubtractiveAction m a | m -> a where
  infixl 6 .-
  (.-) :: a -> m -> m

  infixl 6 -.
  (-.) :: m -> a -> m

-- | Multiplicative Action
--
class
  (Multiplicative a) =>
  MultiplicativeAction m a | m -> a where
  infixl 7 .*
  (.*) :: a -> m -> m
  infixl 7 *.
  (*.) :: m -> a -> m

-- | Divisive Action
--
class
  (Divisive a) =>
  DivisiveAction m a | m -> a where
  infixl 7 ./
  (./) :: a -> m -> m
  infixl 7 /.
  (/.) :: m -> a -> m

-- | A <https://en.wikipedia.org/wiki/Module_(mathematics) Module>
--
-- > a .* one == a
-- > (a + b) .* c == (a .* c) + (b .* c)
-- > c *. (a + b) == (c *. a) + (c *. b)
-- > a .* zero == zero
-- > a .* b == b *. a
class (Distributive a, MultiplicativeAction m a) => Module m a
