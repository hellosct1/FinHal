ALTER TABLE `REF_ALIAS` ADD `OLDREFMD5` BINARY(16) NULL DEFAULT NULL AFTER `OLDREFID`;



-- requetes SQL pour optimisation BdD 
-- étape 1 : modification des types de champs sans impact sur le code pour les tables de plus d'1 million d'enregistrements

-- Attention espac et temps de traitement ALTER TABLE DOC_STAT_COUNTER MODIFY CONSULT ENUM('bibtex','dc','endnote','file','json','notice','oai','sip') NOT NULL;

-- Attention espac et temps de traitement ALTER TABLE DOC_STAT_COUNTER_FULL MODIFY CONSULT ENUM('bibtex','dc','endnote','file','json','notice','oai','sip') NOT NULL;

ALTER TABLE STAT_VISITOR MODIFY CONTINENT ENUM('--','AF','AN','AS','EU','NA','OC','SA') NOT NULL DEFAULT '--';

-- FULL va disparaitre ALTER TABLE STAT_VISITOR_FULL MODIFY CONTINENT ENUM('--','AF','AN','AS','EU','NA','OC','SA') NOT NULL DEFAULT '--';

ALTER TABLE DOCUMENT MODIFY TYPDOC ENUM('ART','COMM','COUV','DOUV','HDR','IMG','LECTURE','MAP','MEM','MINUTES','NOTE','OTHER','OTHERREPORT','OUV','PATENT','POSTER','PRESCONF','REPORT','SON','SYNTHESE','THESE','UNDEFINED','VIDEO') NOT NULL DEFAULT 'UNDEFINED';
ALTER TABLE DOCUMENT MODIFY IDENTIFIANT VARCHAR(25) NOT NULL;   -- 27 s pour 1 067 974 enregistrements
ALTER TABLE DOC_DELETED MODIFY IDENTIFIANT VARCHAR(25) NOT NULL;    -- ok
ALTER TABLE DOC_OWNER MODIFY IDENTIFIANT VARCHAR(25) NOT NULL;    -- ok
ALTER TABLE DOC_OWNER_CLAIM MODIFY IDENTIFIANT VARCHAR(25) NOT NULL;    -- ok
ALTER TABLE DOC_RELATED MODIFY IDENTIFIANT VARCHAR(25) NOT NULL;    -- ok

ALTER TABLE DOCUMENT MODIFY PWD CHAR(8) NOT NULL;   -- ok

ALTER TABLE DOC_FILE MODIFY FILENAME VARCHAR(255) NOT NULL;

ALTER TABLE REF_AUTHOR MODIFY FIRSTNAME VARCHAR(255) NOT NULL;
ALTER TABLE REF_AUTHOR MODIFY MIDDLENAME VARCHAR(255) DEFAULT NULL;
ALTER TABLE REF_AUTHOR MODIFY URL VARCHAR(255) DEFAULT NULL;

--------------------------------------------------------------------------------

-- champ utilisé DROP INDEX IDX_VERSION ON DOCUMENT;         
DROP INDEX IDX_HAVEFILE ON DOCUMENT;        -- champ non utilisé
--CREATE INDEX IDX_DIV ON DOCUMENT(DOCID, IDENTIFIANT, VERSION);
--CREATE INDEX IDX_IDV ON DOCUMENT(IDENTIFIANT, DOCSTATUS, VERSION);
CREATE INDEX IDX_UD ON DOCUMENT(DOCSTATUS, UID);
DROP INDEX IDX_DOCSTATUS ON DOCUMENT;

CREATE INDEX IDX_AD ON DOC_AUTHOR(AUTHORID, DOCID);
DROP INDEX IDX_AUTHOR ON DOC_AUTHOR;

--CREATE INDEX IDX_DS ON DOC_AUTSTRUCT(DOCAUTHID, STRUCTID);
--DROP INDEX IDX_AUTH ON DOC_AUTSTRUCT;

DROP INDEX IDX_MAIN ON DOC_FILE;        -- champ non utilisé
CREATE INDEX IDX_DATE ON DOC_FILE(DATEVISIBLE);
CREATE INDEX IDX_FORMAT ON DOC_FILE(FORMAT);
CREATE INDEX IDX_ARCHIVED ON DOC_FILE(ARCHIVED);

-- champ utilisé DROP INDEX DATELOG ON DOC_LOG;
CREATE INDEX IDX_LM ON DOC_LOG(LOGACTION, MESG, DOCID, UID);
CREATE INDEX IDX_LM ON DOC_LOG(UID, LOGACTION, MESG);
DROP INDEX IDX_ACTION ON DOC_LOG;
DROP INDEX IDX_UID ON DOC_LOG;

DROP INDEX IDX_SID ON DOC_METADATA;        -- champ non utilisé
CREATE INDEX IDX_MDM ON DOC_METADATA(METANAME(25), DOCID, METAVALUE(333));
CREATE INDEX IDX_MM ON DOC_METADATA(METAVALUE(333), METANAME(25));
DROP INDEX IDX_METAVALUE ON DOC_METADATA;
DROP INDEX IDX_NAME ON DOC_METADATA;

CREATE INDEX IDX_UI ON DOC_OWNER(UID, IDENTIFIANT);
DROP INDEX IDX_USER ON DOC_OWNER;

DROP INDEX IDX_FILE ON DOC_STAT_COUNTER;    -- champ non utilisé
 -- champ utilisé DROP INDEX IDX_DATE ON DOC_STAT_COUNTER;
CREATE INDEX IDX_DDC ON DOC_STAT_COUNTER(DOCID, DHIT, CHIT);
CREATE INDEX IDX_DUCFVD ON DOC_STAT_COUNTER(DOCID, UID, CONSULT, FILEID, VID, DHIT);
DROP INDEX IDX_DOCID ON DOC_STAT_COUNTER;

-- FULL va disparaitre DROP INDEX U_STAT ON DOC_STAT_COUNTER_FULL;
-- FULL va disparaitre DROP INDEX IDX_FILE ON DOC_STAT_COUNTER_FULL;
-- FULL va disparaitre DROP INDEX IDX_DATE ON DOC_STAT_COUNTER_FULL;
-- FULL va disparaitre DROP INDEX IDX_DOCID ON DOC_STAT_COUNTER_FULL;
-- FULL va disparaitre DROP INDEX IDX_CONSULT ON DOC_STAT_COUNTER_FULL;
-- FULL va disparaitre DROP INDEX IDX_VISIT ON DOC_STAT_COUNTER_FULL;

 -- champ utilisé DROP INDEX IDX_UID ON DOC_TAMPON;

CREATE INDEX IDX_VALID ON REF_AUTHOR(VALID);
CREATE INDEX IDX_LFEIV ON REF_AUTHOR(LASTNAME(333), FIRSTNAME(220), EMAIL, IDHAL, VALID);
DROP INDEX IDX_LAST ON REF_AUTHOR;

DROP INDEX IDX_ROBO ON STAT_VISITOR;

DROP INDEX U_VISITOR ON STAT_VISITOR_FULL;      -- fait
DROP INDEX IDX_IP ON STAT_VISITOR_FULL;         -- fait
DROP INDEX IDX_ROBO ON STAT_VISITOR_FULL;       -- fait
DROP INDEX IDX_CONTINENT ON STAT_VISITOR_FULL;  -- fait
DROP INDEX IDX_COUNTRY ON STAT_VISITOR_FULL;    -- fait
DROP INDEX IDX_CITY ON STAT_VISITOR_FULL;

--------------------------------------------------------------------------------

ALTER TABLE CV_STAT_COUNTER MODIFY COUNTER smallint unsigned not null;  -- ok

-- REF_PROJEUROP données à revoir

ALTER TABLE REF_STRUCTURE MODIFY SIGLE VARCHAR(255) DEFAULT NULL;

ALTER TABLE REF_STRUCT_PARENT MODIFY CODE VARCHAR(255) NOT NULL;

-- clé primaire ALTER TABLE USER MODIFY UID INT(10) UNSIGNED NOT NULL;
-- clé primaire ALTER TABLE DOC_OWNER_CLAIM MODIFY UID INT(10) UNSIGNED NOT NULL;
ALTER TABLE NEWS MODIFY UID INT(10) UNSIGNED NOT NULL;
-- clé primaire ALTER TABLE USER_CONNEXION MODIFY UID INT(10) UNSIGNED NOT NULL;
ALTER TABLE USER_MODER_MSG MODIFY UID INT(10) UNSIGNED NOT NULL;
ALTER TABLE USER_MODER_TMP MODIFY UID INT(10) UNSIGNED NOT NULL;
ALTER TABLE USER_STAT_QUERIES MODIFY UID INT(10) UNSIGNED NOT NULL;
ALTER TABLE VISITEURS MODIFY UID INT(10) UNSIGNED NOT NULL;

--------------------------------------------------------------------------------

DROP INDEX IDX_DOCID ON COLLECTION_DOC_HIDDEN;  --ok

DROP INDEX IDX_DATE ON CV_STAT_COUNTER;   -- ok
DROP INDEX IDX_VISIT ON CV_STAT_COUNTER;   -- ok

DROP INDEX U_STAT ON CV_STAT_COUNTER_FULL;      -- fait
DROP INDEX IDX_DOCID ON CV_STAT_COUNTER_FULL;   -- fait
DROP INDEX IDX_DATE ON CV_STAT_COUNTER_FULL;    -- fait
DROP INDEX IDX_VISIT ON CV_STAT_COUNTER_FULL;   -- fait

DROP INDEX IDPAC ON DOC_ARCHIVE;
CREATE INDEX IDX_DS ON DOC_ARCHIVE(DOCID, SEND);
CREATE INDEX IDX_DA ON DOC_ARCHIVE(DOCID, ACTION);
DROP INDEX DOCID ON DOC_ARCHIVE;

-- ATTENTION clé unique DROP INDEX U_IDEXT ON DOC_HASCOPY;
CREATE INDEX IDX_LC ON DOC_HASCOPY(LOCALID, COPY);

DROP INDEX UID ON REF_LOG;
CREATE INDEX IDX_IAD ON REF_LOG(ID_TAB, ACTION, DATE_ACTION);
CREATE INDEX IDX_TN ON REF_LOG(TABLE_NAME);
CREATE INDEX IDX_TN ON REF_LOG(ACTION);
CREATE INDEX IDX_PREV ON REF_LOG(PREV_VALUES(255));

DROP INDEX IDX_NUMBER ON REF_PROJEUROP;
-- ATTENTION clé unique DROP INDEX U_MD5 ON REF_PROJEUROP;
CREATE INDEX IDX_FUND ON REF_PROJEUROP(FUNDEDBY);
CREATE INDEX IDX_CALL ON REF_PROJEUROP(CALLID);
CREATE INDEX IDX_MP ON REF_PROJEUROP(MD5, PROJEUROPID);

-- ATTENTION clé unique DROP INDEX U_MD5 ON REF_STRUCTURE;
DROP INDEX IDX_NAME ON REF_STRUCTURE;
DROP INDEX IDX_SIGLE ON REF_STRUCTURE;
CREATE INDEX IDX_MD ON REF_STRUCTURE(MD5, STRUCTID);

DROP INDEX IDX_LANG ON USER;

--------------------------------------------------------------------------------

-- clé primaire ALTER TABLE COLLECTION_SETTINGS MODIFY SID INT(10) UNSIGNED NOT NULL;

ALTER TABLE DOC_IDARXIV MODIFY PENDING CHAR(40) DEFAULT NULL;

ALTER TABLE REF_JOURNAL MODIFY JANME TEXT NOT NULL;
ALTER TABLE REF_JOURNAL MODIFY ISSN CHAR(25) DEFAULT NULL;
ALTER TABLE REF_JOURNAL MODIFY EISSN CHAR(10) DEFAULT NULL;

-- REF_PROJANR données à revoir

-- clé primaire ALTER TABLE USER_CONNEXION MODIFY UID INT(10) UNSIGNED NOT NULL;
-- clé primaire ALTER TABLE USER_CONNEXION MODIFY SID INT(10) UNSIGNED NOT NULL;
ALTER TABLE USER_CONNEXION MODIFY NB_CONNEXION SMALLINT UNSIGNED NOT NULL DEFAULT 0;

ALTER TABLE USER_LIBRARY_DOC MODIFY LIBSHELFID SMALLINT UNSIGNED NOT NULL;

ALTER TABLE USER_RIGHT MODIFY VALUE TEXT NOT NULL;

ALTER TABLE USER_SEARCH MODIFY URL TEXT NOT NULL;
ALTER TABLE USER_SEARCH MODIFY URL_API TEXT NOT NULL;

-- clé primaire ALTER TABLE WEBSITE_HEADER MODIFY LOGOID INT(10) UNSIGNED NOT NULL AUTO_INCREMENT;
-- clé primaire ALTER TABLE WEBSITE_HEADER MODIFY SID INT(10) UNSIGNED NOT NULL;

ALTER TABLE WEBSITE_NAVIGATION MODIFY SID INT(10) UNSIGNED NOT NULL;
ALTER TABLE WEBSITE_NAVIGATION MODIFY PAGEID SMALLINT UNSIGNED NOT NULL;
ALTER TABLE WEBSITE_NAVIGATION MODIFY TYPE_PAGE CHAR(10) NOT NULL;
ALTER TABLE WEBSITE_NAVIGATION MODIFY LABEL VARCHAR(255) NOT NULL;
ALTER TABLE WEBSITE_NAVIGATION MODIFY PARENT_PAGEID SMALLINT UNSIGNED NOT NULL;

-- clé primaire ALTER TABLE WEBSITE_STYLES MODIFY SID INT(10) UNSIGNED NOT NULL;
ALTER TABLE WEBSITE_STYLES MODIFY VALUE VARCHAR(255) NOT NULL;

--------------------------------------------------------------------------------

CREATE INDEX IDX_SV ON COLLECTION_SETTINGS(SETTING, VALUE);
DROP INDEX IDX_SETTING ON COLLECTION_SETTINGS;

-- ATTENTION clé unique DROP INDEX U_ID ON DOC_AUTHOR_IDEXT;
DROP INDEX IDX_DOCID ON DOC_AUTHOR_IDEXT;
CREATE INDEX IDX_AD ON DOC_AUTHOR_IDEXT(AUTHORID, DOCID);
DROP INDEX IDX_AUTH ON DOC_AUTHOR_IDEXT;

CREATE INDEX IDX_ARXIVID ON DOC_IDARXIV(ARXIVID);

DROP INDEX OLDREFID ON REF_ALIAS;
DROP INDEX REFNOM ON REF_ALIAS;

CREATE INDEX IDX_SNAME ON REF_JOURNAL(SHORTNAME(80));
CREATE INDEX IDX_ISSN ON REF_JOURNAL(ISSN(22));
CREATE INDEX IDX_PUB ON REF_JOURNAL(PUBLISHER));

-- REF_PROJANR données à revoir

DROP INDEX UID ON USER_CONNEXION;

DROP INDEX IDX_UID ON USER_LIBRARY_DOC;
-- ATTENTION clé unique DROP INDEX U_DOCSHELF ON USER_LIBRARY_DOC;
CREATE INDEX IDX_ULS ON USER_LIBRARY_DOC(UID, LIBSHELFID);
CREATE INDEX IDX_IU ON USER_LIBRARY_DOC(IDENTIFIANT, UID);

CREATE INDEX IDX_RSVU ON USER_RIGHT(RIGHTID, SID, VALUE, UID);
DROP INDEX IDX_RIGHT ON USER_RIGHT;

CREATE INDEX IDX_STA ON WEBSITE_NAVIGATION(SID, TYPE_PAGE, ACTION);

DROP INDEX SETTING ON WEBSITE_STYLES;

--------------------------------------------------------------------------------

CREATE INDEX IDX_IDENT ON DOC_OWNER_CLAIM(IDENTIFIANT);

DROP INDEX IDX_ID ON DOC_RELATED;

