drop table users;
drop sequence seq_video_no;
drop table video;
drop sequence seq_notice_no;
drop table notice;
drop sequence seq_post_no;
drop table post;
drop sequence seq_cmt_no;
drop table comments;
drop table scrap;
drop table qna;
drop sequence seq_qna_no;
drop table likes;

CREATE TABLE users (
    user_id VARCHAR2(20) not null,
    user_name   VARCHAR2(30) not null,
    user_email	VARCHAR2(100) not null,
    user_addr   VARCHAR2(200) not null,
    user_tel    VARCHAR2(20) not null,
    user_pwd    VARCHAR2(30) not null,
    user_nickname   VARCHAR2(50) not null,
    user_level  VARCHAR2(30) not null,
    reg_date    DATE DEFAULT SYSDATE,
    PRIMARY KEY(user_id)
);
ALTER TABLE users
MODIFY (user_nickname VARCHAR2(50));

update users
set user_level='administer'
where user_id='realso0';

CREATE TABLE video (
    video_no NUMBER(30) not null,
    user_id VARCHAR2(20) not null,
    video_origin_name   VARCHAR2(200) not null,
    video_save_name VARCHAR2(200) not null,
    video_ex_name   VARCHAR2(200) not null,
    video_path  VARCHAR2(1000) not null,
    video_size  NUMBER(20) not null,
    video_date  DATE DEFAULT SYSDATE not null,
    video_thumnail VARCHAR2(200) not null,
    video_correct_line  VARCHAR2(100) not null,
    video_delete VARCHAR2(10) not null,
    PRIMARY KEY(video_no),
    CONSTRAINT c_video_fk FOREIGN KEY (user_id) 
    REFERENCES users(user_id)
);

CREATE SEQUENCE seq_video_no
INCREMENT BY 1
START WITH 1;

CREATE TABLE notice (
    noti_no NUMBER(10) not null,
    noti_title  VARCHAR2(255) not null,
    noti_content    VARCHAR2(4000) not null,
    noti_date   DATE DEFAULT SYSDATE not null,
    noti_hit_cnt    NUMBER DEFAULT 0 not null,
    user_id VARCHAR2(20) not null,
    PRIMARY KEY(noti_no),
    CONSTRAINT c_notice_fk FOREIGN KEY (user_id) 
    REFERENCES users(user_id)
);

CREATE SEQUENCE seq_notice_no
INCREMENT BY 1 
START WITH 1;

CREATE TABLE post (
    post_no NUMBER(10) not null,
    writer_id VARCHAR2(20) not null,
    video_no NUMBER(30) not null,
    post_title  VARCHAR2(255) not null,
    post_content    VARCHAR2(300) not null,
    post_date   DATE DEFAULT SYSDATE not null,
    post_soi_cnt    NUMBER DEFAULT 0 not null,
    post_cmt_cnt    NUMBER DEFAULT 0 not null,
    post_hit_cnt    NUMBER DEFAULT 0 not null,
    post_hide_face  VARCHAR2(10) default 'N' not null,
    post_sharable   VARCHAR2(10) default 'N' not null,
    post_anal_result    VARCHAR2(100),
    PRIMARY KEY(post_no),
    CONSTRAINT c_post_writerid_fk FOREIGN KEY (writer_id) 
    REFERENCES users(user_id),
    CONSTRAINT c_post_videono_fk FOREIGN KEY (video_no) 
    REFERENCES video(video_no)
);

CREATE SEQUENCE seq_post_no
INCREMENT BY 1
START WITH 1;

CREATE TABLE comments (
    cmt_no NUMBER(10) not null,
    post_no NUMBER(10) not null,
    user_id VARCHAR2(20) not null,
    cmt_content VARCHAR2(4000) not null,
    cmt_date    DATE DEFAULT SYSDATE not null,
    PRIMARY KEY(cmt_no),
    CONSTRAINT c_comments_postno_fk FOREIGN KEY (post_no) 
    REFERENCES post(post_no),
    CONSTRAINT c_comments_userid_fk FOREIGN KEY (user_id) 
    REFERENCES users(user_id)
);
alter table "HISOI"."COMMENTS" drop constraint "C_COMMENTS_POSTNO_FK";
alter table comments add constraint c_comments_postno_fk foreign key(post_no)
references post(post_no) on delete cascade;

CREATE SEQUENCE seq_cmt_no
INCREMENT BY 1
START WITH 1;

CREATE TABLE scrap (
    post_no NUMBER(10) not null,
    user_id VARCHAR2(20) not null,
    scrap_date    DATE DEFAULT SYSDATE not null,
    CONSTRAINT c_scrap_postno_fk FOREIGN KEY (post_no) 
    REFERENCES post(post_no),
    CONSTRAINT c_scrap_userid_fk FOREIGN KEY (user_id) 
    REFERENCES users(user_id)
);
alter table "HISOI"."SCRAP" drop constraint "C_SCRAP_POSTNO_FK";
alter table scrap add constraint c_scrap_postno_fk foreign key(post_no)
references post(post_no) on delete cascade;

CREATE TABLE qna (
    qna_no NUMBER(30) not null,
    qna_title VARCHAR2(100) not null,
    qna_content VARCHAR2(2000) not null,
    reg_date DATE default sysdate not null,
    user_id VARCHAR2(20) not null,
    qna_hit_cnt NUMBER DEFAULT 0 not null,
    PRIMARY KEY(qna_no),
    CONSTRAINT c_qna_fk FOREIGN KEY (user_id)
    REFERENCES users(user_id)
);

CREATE SEQUENCE seq_qna_no
INCREMENT BY 1
START WITH 1;

insert into qna (qna_no, qna_title, qna_content, reg_date, user_id, qna_hit_cnt)
(select seq_qna_no.nextval, qna_title, qna_content, reg_date, user_id, qna_hit_cnt from qna);

CREATE TABLE likes (
    post_no NUMBER(10) not null,
    user_id VARCHAR2(20) not null,
    like_date    DATE DEFAULT SYSDATE not null,
    CONSTRAINT c_likes_postno_fk FOREIGN KEY (post_no) 
    REFERENCES post(post_no) on delete cascade,
    CONSTRAINT c_likes_userid_fk FOREIGN KEY (user_id) 
    REFERENCES users(user_id)
);

commit;
rollback;