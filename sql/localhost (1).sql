-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- ホスト: localhost
-- 生成日時: 2023-04-19 09:27:36
-- サーバのバージョン： 10.4.27-MariaDB
-- PHP のバージョン: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- データベース: `dict`
--
CREATE DATABASE IF NOT EXISTS `dict` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `dict`;

-- --------------------------------------------------------

--
-- テーブルの構造 `follows`
--

CREATE TABLE `follows` (
  `id` int(11) NOT NULL,
  `follower_id` int(11) DEFAULT NULL,
  `followed_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `meanings`
--

CREATE TABLE `meanings` (
  `id` int(11) NOT NULL,
  `word_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `meaning` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `public_lists`
--

CREATE TABLE `public_lists` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `public_list_words`
--

CREATE TABLE `public_list_words` (
  `id` int(11) NOT NULL,
  `public_list_id` int(11) DEFAULT NULL,
  `word_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `tags`
--

CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `tag` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `words`
--

CREATE TABLE `words` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `word` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `word_tags`
--

CREATE TABLE `word_tags` (
  `id` int(11) NOT NULL,
  `word_id` int(11) DEFAULT NULL,
  `tag_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- ダンプしたテーブルのインデックス
--

--
-- テーブルのインデックス `follows`
--
ALTER TABLE `follows`
  ADD PRIMARY KEY (`id`),
  ADD KEY `follower_id` (`follower_id`),
  ADD KEY `followed_id` (`followed_id`);

--
-- テーブルのインデックス `meanings`
--
ALTER TABLE `meanings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `word_id` (`word_id`),
  ADD KEY `user_id` (`user_id`);

--
-- テーブルのインデックス `public_lists`
--
ALTER TABLE `public_lists`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- テーブルのインデックス `public_list_words`
--
ALTER TABLE `public_list_words`
  ADD PRIMARY KEY (`id`),
  ADD KEY `public_list_id` (`public_list_id`),
  ADD KEY `word_id` (`word_id`);

--
-- テーブルのインデックス `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `words`
--
ALTER TABLE `words`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- テーブルのインデックス `word_tags`
--
ALTER TABLE `word_tags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `word_id` (`word_id`),
  ADD KEY `tag_id` (`tag_id`);

--
-- ダンプしたテーブルの制約
--

--
-- テーブルの制約 `follows`
--
ALTER TABLE `follows`
  ADD CONSTRAINT `follows_ibfk_1` FOREIGN KEY (`follower_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `follows_ibfk_2` FOREIGN KEY (`followed_id`) REFERENCES `users` (`id`);

--
-- テーブルの制約 `meanings`
--
ALTER TABLE `meanings`
  ADD CONSTRAINT `meanings_ibfk_1` FOREIGN KEY (`word_id`) REFERENCES `words` (`id`),
  ADD CONSTRAINT `meanings_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- テーブルの制約 `public_lists`
--
ALTER TABLE `public_lists`
  ADD CONSTRAINT `public_lists_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- テーブルの制約 `public_list_words`
--
ALTER TABLE `public_list_words`
  ADD CONSTRAINT `public_list_words_ibfk_1` FOREIGN KEY (`public_list_id`) REFERENCES `public_lists` (`id`),
  ADD CONSTRAINT `public_list_words_ibfk_2` FOREIGN KEY (`word_id`) REFERENCES `words` (`id`);

--
-- テーブルの制約 `words`
--
ALTER TABLE `words`
  ADD CONSTRAINT `words_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- テーブルの制約 `word_tags`
--
ALTER TABLE `word_tags`
  ADD CONSTRAINT `word_tags_ibfk_1` FOREIGN KEY (`word_id`) REFERENCES `words` (`id`),
  ADD CONSTRAINT `word_tags_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
