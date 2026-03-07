PRAGMA foreign_keys = ON;

-- =========================================
-- SISTEM GESTIUNE BIBLIOTECĂ - SQLite
-- =========================================

DROP TABLE IF EXISTS imprumuturi;
DROP TABLE IF EXISTS carti_autori;
DROP TABLE IF EXISTS cititori;
DROP TABLE IF EXISTS carti;
DROP TABLE IF EXISTS autori;
DROP TABLE IF EXISTS operatori;

-- =========================================
-- TABELA OPERATORI
-- =========================================
CREATE TABLE operatori (
    id_operator     INTEGER PRIMARY KEY AUTOINCREMENT,
    nume            TEXT NOT NULL,
    prenume         TEXT NOT NULL,
    username        TEXT NOT NULL UNIQUE,
    parola          TEXT NOT NULL,
    rol             TEXT NOT NULL DEFAULT 'operator'
                    CHECK (rol IN ('administrator', 'operator')),
    email           TEXT UNIQUE,
    telefon         TEXT,
    status_cont     TEXT NOT NULL DEFAULT 'activ'
                    CHECK (status_cont IN ('activ', 'inactiv', 'blocat'))
);

-- =========================================
-- TABELA AUTORI
-- =========================================
CREATE TABLE autori (
    id_autor        INTEGER PRIMARY KEY AUTOINCREMENT,
    nume            TEXT NOT NULL,
    prenume         TEXT NOT NULL,
    nationalitate   TEXT,
    an_nastere      INTEGER
                    CHECK (an_nastere IS NULL OR an_nastere BETWEEN 1000 AND 2100)
);

-- =========================================
-- TABELA CARTI
-- =========================================
CREATE TABLE carti (
    id_carte         INTEGER PRIMARY KEY AUTOINCREMENT,
    titlu            TEXT NOT NULL,
    gen              TEXT,
    an_aparitie      INTEGER
                     CHECK (an_aparitie IS NULL OR an_aparitie BETWEEN 1000 AND 2100),
    isbn             TEXT UNIQUE,
    editura          TEXT,
    nr_exemplare     INTEGER NOT NULL DEFAULT 1
                     CHECK (nr_exemplare >= 0),
    nr_disponibile   INTEGER NOT NULL DEFAULT 1
                     CHECK (nr_disponibile >= 0 AND nr_disponibile <= nr_exemplare)
);

-- =========================================
-- TABELA INTERMEDIARĂ CARTI_AUTORI
-- Relație many-to-many între carti și autori
-- =========================================
CREATE TABLE carti_autori (
    id_carte        INTEGER NOT NULL,
    id_autor        INTEGER NOT NULL,
    PRIMARY KEY (id_carte, id_autor),
    FOREIGN KEY (id_carte) REFERENCES carti(id_carte)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (id_autor) REFERENCES autori(id_autor)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- =========================================
-- TABELA CITITORI
-- =========================================
CREATE TABLE cititori (
    id_cititor           INTEGER PRIMARY KEY AUTOINCREMENT,
    nume                 TEXT NOT NULL,
    prenume              TEXT NOT NULL,
    cod_unic             TEXT NOT NULL UNIQUE,
    telefon              TEXT,
    email                TEXT UNIQUE,
    adresa               TEXT,
    data_inregistrare    TEXT NOT NULL DEFAULT (date('now')),
    status_cititor       TEXT NOT NULL DEFAULT 'activ'
                         CHECK (status_cititor IN ('activ', 'inactiv', 'suspendat'))
);

-- =========================================
-- TABELA IMPRUMUTURI
-- =========================================
CREATE TABLE imprumuturi (
    id_imprumut       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cititor        INTEGER NOT NULL,
    id_carte          INTEGER NOT NULL,
    id_operator       INTEGER NOT NULL,
    data_imprumut     TEXT NOT NULL DEFAULT (date('now')),
    data_scadenta     TEXT NOT NULL,
    data_returnare    TEXT,
    status_imprumut   TEXT NOT NULL DEFAULT 'activ'
                      CHECK (status_imprumut IN ('activ', 'returnat', 'intarziat')),

    FOREIGN KEY (id_cititor) REFERENCES cititori(id_cititor)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    FOREIGN KEY (id_carte) REFERENCES carti(id_carte)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    FOREIGN KEY (id_operator) REFERENCES operatori(id_operator)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CHECK (
        data_returnare IS NULL OR
        julianday(data_returnare) >= julianday(data_imprumut)
    ),
    CHECK (
        julianday(data_scadenta) >= julianday(data_imprumut)
    )
);

-- =========================================
-- INDICI
-- =========================================
CREATE INDEX idx_autori_nume ON autori(nume, prenume);
CREATE INDEX idx_carti_titlu ON carti(titlu);
CREATE INDEX idx_carti_isbn ON carti(isbn);
CREATE INDEX idx_cititori_nume ON cititori(nume, prenume);
CREATE INDEX idx_cititori_cod_unic ON cititori(cod_unic);
CREATE INDEX idx_imprumuturi_cititor ON imprumuturi(id_cititor);
CREATE INDEX idx_imprumuturi_carte ON imprumuturi(id_carte);
CREATE INDEX idx_imprumuturi_operator ON imprumuturi(id_operator);
CREATE INDEX idx_imprumuturi_status ON imprumuturi(status_imprumut);

-- =========================================
-- TRIGGER: verifică disponibilitatea înainte de împrumut
-- =========================================
CREATE TRIGGER trg_verifica_disponibilitate_inainte_imprumut
BEFORE INSERT ON imprumuturi
FOR EACH ROW
BEGIN
    SELECT
        CASE
            WHEN (SELECT nr_disponibile FROM carti WHERE id_carte = NEW.id_carte) <= 0
            THEN RAISE(ABORT, 'Nu exista exemplare disponibile pentru aceasta carte.')
        END;
END;

-- =========================================
-- TRIGGER: scade nr_disponibile după împrumut activ
-- =========================================
CREATE TRIGGER trg_scade_disponibil_la_imprumut
AFTER INSERT ON imprumuturi
FOR EACH ROW
WHEN NEW.status_imprumut = 'activ'
BEGIN
    UPDATE carti
    SET nr_disponibile = nr_disponibile - 1
    WHERE id_carte = NEW.id_carte;
END;

-- =========================================
-- TRIGGER: crește nr_disponibile la returnare
-- Se activează când un împrumut trece din activ/intarziat în returnat
-- =========================================
CREATE TRIGGER trg_creste_disponibil_la_returnare
AFTER UPDATE OF status_imprumut, data_returnare ON imprumuturi
FOR EACH ROW
WHEN OLD.status_imprumut IN ('activ', 'intarziat')
 AND NEW.status_imprumut = 'returnat'
BEGIN
    UPDATE carti
    SET nr_disponibile = nr_disponibile + 1
    WHERE id_carte = NEW.id_carte;
END;

-- =========================================
-- TRIGGER: împiedică dublarea returnării
-- =========================================
CREATE TRIGGER trg_previne_returnare_repetata
BEFORE UPDATE OF status_imprumut ON imprumuturi
FOR EACH ROW
WHEN OLD.status_imprumut = 'returnat' AND NEW.status_imprumut = 'returnat'
BEGIN
    SELECT RAISE(ABORT, 'Acest imprumut este deja returnat.');
END;

-- =========================================
-- TRIGGER: data_returnare obligatorie când status = returnat
-- =========================================
CREATE TRIGGER trg_verifica_data_returnare
BEFORE UPDATE OF status_imprumut ON imprumuturi
FOR EACH ROW
WHEN NEW.status_imprumut = 'returnat' AND NEW.data_returnare IS NULL
BEGIN
    SELECT RAISE(ABORT, 'Pentru status returnat trebuie completata data_returnare.');
END;

-- =========================================
-- OPERATOR IMPLICIT PENTRU TEST
-- TODO:parola trebuie stocată hash-uită
-- =========================================
INSERT INTO operatori (
    nume, prenume, username, parola, rol, email, telefon, status_cont
) VALUES (
    'admin', 'admin', 'admin', 'admin123', 'administrator',
    'admin@biblioteca.local', '0700000000', 'activ'
);
INSERT INTO operatori (
    nume, prenume, username, parola, rol, email, telefon, status_cont
) VALUES (
    'Rosca', 'Dragos-Florin', 'dragos.rosca', 'parola123', 'operator',
    'dragos.rosca@student.usv.ro', '0700000000', 'activ'
);
