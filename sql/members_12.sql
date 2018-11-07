# Host: localhost  (Version: 5.5.53)
# Date: 2018-11-07 17:32:12
# Generator: MySQL-Front 5.3  (Build 4.234)

/*!40101 SET NAMES utf8 */;

#
# Structure for table "admin"
#

CREATE TABLE `admin` (
  `a_id` int(11) NOT NULL AUTO_INCREMENT,
  `a_name` varchar(20) NOT NULL,
  `a_password` varchar(50) NOT NULL,
  PRIMARY KEY (`a_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

#
# Structure for table "album"
#

CREATE TABLE `album` (
  `album_id` int(11) NOT NULL AUTO_INCREMENT,
  `album_name` varchar(20) NOT NULL,
  `album_content` varchar(100) NOT NULL,
  `album_time` varchar(20) NOT NULL,
  `album_url` varchar(20) NOT NULL,
  `album_type` int(4) NOT NULL,
  PRIMARY KEY (`album_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

#
# Structure for table "areply"
#

CREATE TABLE `areply` (
  `areply_id` int(11) NOT NULL AUTO_INCREMENT,
  `areply_owner` varchar(20) CHARACTER SET utf8 NOT NULL,
  `areply_realowner` varchar(20) CHARACTER SET utf8 NOT NULL,
  `areply_content` varchar(1000) CHARACTER SET utf8 NOT NULL,
  `areply_time` varchar(20) CHARACTER SET utf8 NOT NULL,
  `post_reply_id` int(11) NOT NULL,
  PRIMARY KEY (`areply_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

#
# Structure for table "borrow_book"
#

CREATE TABLE `borrow_book` (
  `borrow_id` int(11) NOT NULL AUTO_INCREMENT,
  `borrow_realname` varchar(20) NOT NULL,
  `borrow_time` date NOT NULL,
  `book_id` int(11) NOT NULL,
  PRIMARY KEY (`borrow_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

#
# Structure for table "news"
#

CREATE TABLE `news` (
  `news_id` int(11) NOT NULL AUTO_INCREMENT,
  `news_title` varchar(20) NOT NULL,
  `news_content` varchar(1000) NOT NULL,
  `news_time` varchar(20) NOT NULL,
  PRIMARY KEY (`news_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

#
# Structure for table "picture"
#

CREATE TABLE `picture` (
  `picture_id` int(11) NOT NULL AUTO_INCREMENT,
  `picture_name` varchar(50) NOT NULL,
  `picture_title` varchar(50) NOT NULL,
  `picture_introduction` varchar(100) DEFAULT NULL,
  `picture_time` varchar(20) NOT NULL,
  `picture_owner` varchar(20) NOT NULL,
  `picture_realowner` varchar(20) NOT NULL,
  `album_id` int(11) NOT NULL,
  PRIMARY KEY (`picture_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

#
# Structure for table "post"
#

CREATE TABLE `post` (
  `post_id` int(11) NOT NULL AUTO_INCREMENT,
  `post_name` varchar(20) NOT NULL,
  `post_content` varchar(1000) NOT NULL,
  `post_owner` varchar(20) NOT NULL,
  `post_realowner` varchar(20) NOT NULL,
  `post_time` varchar(20) NOT NULL,
  PRIMARY KEY (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;

#
# Structure for table "post_reply"
#

CREATE TABLE `post_reply` (
  `post_reply_id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) NOT NULL,
  `post_reply_owner` varchar(20) NOT NULL,
  `post_reply_realowner` varchar(20) NOT NULL,
  `post_reply_content` varchar(1000) NOT NULL,
  `post_reply_time` varchar(20) NOT NULL,
  PRIMARY KEY (`post_reply_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

#
# Structure for table "question"
#

CREATE TABLE `question` (
  `question_id` int(11) NOT NULL AUTO_INCREMENT,
  `question_owner` varchar(20) NOT NULL,
  `question_realowner` varchar(20) NOT NULL,
  `question_content` varchar(1000) DEFAULT NULL,
  `question_time` varchar(20) NOT NULL,
  PRIMARY KEY (`question_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

#
# Structure for table "question_reply"
#

CREATE TABLE `question_reply` (
  `question_reply_id` int(11) NOT NULL AUTO_INCREMENT,
  `question_reply_admin` varchar(20) NOT NULL,
  `question_reply_content` varchar(1000) DEFAULT NULL,
  `question_reply_time` varchar(20) NOT NULL,
  `question_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`question_reply_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

#
# Structure for table "r_book"
#

CREATE TABLE `r_book` (
  `book_id` int(11) NOT NULL AUTO_INCREMENT,
  `book_number` varchar(20) NOT NULL,
  `book_name` varchar(30) NOT NULL,
  `book_count` int(11) NOT NULL,
  `book_type` varchar(20) NOT NULL,
  PRIMARY KEY (`book_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

#
# Structure for table "r_download"
#

CREATE TABLE `r_download` (
  `download_id` int(11) NOT NULL AUTO_INCREMENT,
  `download_content` varchar(100) NOT NULL,
  `download_count` int(11) DEFAULT NULL,
  `download_owner` varchar(20) NOT NULL,
  `download_realowner` varchar(20) NOT NULL,
  `download_time` varchar(20) NOT NULL,
  PRIMARY KEY (`download_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Structure for table "r_language"
#

CREATE TABLE `r_language` (
  `language_id` int(11) NOT NULL,
  `language_content` text NOT NULL,
  PRIMARY KEY (`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Structure for table "r_share"
#

CREATE TABLE `r_share` (
  `share_id` int(11) NOT NULL,
  `share_owner` varchar(20) NOT NULL,
  `share_realowner` varchar(20) NOT NULL,
  `share_content` varchar(100) NOT NULL,
  `share_time` varchar(20) NOT NULL,
  PRIMARY KEY (`share_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Structure for table "r_web"
#

CREATE TABLE `r_web` (
  `web_id` int(11) NOT NULL,
  `web_content` varchar(100) NOT NULL,
  PRIMARY KEY (`web_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Structure for table "test_answer"
#

CREATE TABLE `test_answer` (
  `test_id` int(11) NOT NULL,
  `test_name` varchar(50) NOT NULL,
  `test_option_answer` varchar(2) DEFAULT NULL,
  `test_program_answer` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`test_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Structure for table "test_content"
#

CREATE TABLE `test_content` (
  `test_option_content` varchar(50) NOT NULL,
  `test_program_content` varchar(50) NOT NULL,
  `test_id` int(50) NOT NULL,
  PRIMARY KEY (`test_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Structure for table "test_result"
#

CREATE TABLE `test_result` (
  `test_id` int(50) NOT NULL,
  `test_option_result` varchar(2) NOT NULL,
  `test_program_result` varchar(50) NOT NULL,
  PRIMARY KEY (`test_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Structure for table "user"
#

CREATE TABLE `user` (
  `u_id` int(11) NOT NULL AUTO_INCREMENT,
  `u_name` varchar(20) CHARACTER SET utf8 NOT NULL,
  `u_password` varchar(50) CHARACTER SET utf8 NOT NULL,
  `u_realname` varchar(20) CHARACTER SET utf8 NOT NULL,
  `u_age` int(11) NOT NULL,
  `u_sex` varchar(5) CHARACTER SET utf8 NOT NULL,
  `u_address` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `u_hpicture` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `u_institute` varchar(50) CHARACTER SET utf8 NOT NULL,
  `u_major` varchar(20) CHARACTER SET utf8 NOT NULL,
  `u_class` varchar(20) CHARACTER SET utf8 NOT NULL,
  `u_studentid` varchar(20) CHARACTER SET utf8 NOT NULL,
  `u_email` varchar(50) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`u_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
