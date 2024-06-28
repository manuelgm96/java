{-# OPTIONS_GHC -Wall #-}
module LogAnalysis where 

import Log

parseMessage :: String -> LogMessage
parseMessage s = case words s of 
                    ("I":ts:msg) -> LogMessage Info (read ts) (unwords msg)
                    ("W":ts:msg) -> LogMessage Warning (read ts) (unwords msg)
                    ("E":lvl:ts:msg) -> LogMessage (Error $ read lvl) (read ts) (unwords msg)
                    _ -> Unknown s

parse :: String -> [LogMessage]
parse input = map parseMessage (lines input)
--parse = map parseMessage . lines

insert :: LogMessage -> MessageTree -> MessageTree
insert param Leaf = Node Leaf param Leaf
insert param@(LogMessage _ ts1 _) (Node left lmsg@(LogMessage _ ts2 _) right)
 | ts1 > ts2 = Node left lmsg (insert param right)
 | otherwise = Node (insert param right) lmsg left
insert _ tree = tree

build :: [LogMessage] -> MessageTree
build = foldr insert Leaf

inOrder :: MessageTree -> [LogMessage]
inOrder Leaf = []
inOrder (Node left msg right) = inOrder left ++ [msg] ++ inOrder right

whatWentWrong :: [LogMessage] -> [String]
whatWentWrong asd@[LogMessage _ ts _] = extractMessage(inOrder(build(filter(\x -> ts > 4) asd)))
whatWentWrong aya = extractMessage(inOrder(build aya))

extractMessage :: [LogMessage] -> [String]
extractMessage (LogMessage _ _ msg : msgs) = msg : extractMessage msgs
extractMessage _ = []