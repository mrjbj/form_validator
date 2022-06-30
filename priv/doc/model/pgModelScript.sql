-- Diff code generated with pgModeler (PostgreSQL Database Modeler)
-- pgModeler version: 1.0.0-alpha
-- Diff date: 2022-06-30 10:44:20
-- Source model: form_validator_dev
-- Database: form_validator_dev
-- PostgreSQL version: 14.0

-- [ Diff summary ]
-- Dropped objects: 0
-- Created objects: 4
-- Changed objects: 0

SET search_path=public,pg_catalog;
-- ddl-end --


-- [ Created objects ] --
-- object: public.addresses | type: TABLE --
-- DROP TABLE IF EXISTS public.addresses CASCADE;
CREATE TABLE public.addresses (
	id smallint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	user_id smallint NOT NULL,
	number smallint,
	street text,
	city text,
	state text,
	postal_code text

);
-- ddl-end --
ALTER TABLE public.addresses OWNER TO postgres;
-- ddl-end --

-- object: addresses_ak | type: INDEX --
-- DROP INDEX IF EXISTS public.addresses_ak CASCADE;
CREATE INDEX addresses_ak ON public.addresses
USING btree
(
	user_id,
	number,
	street,
	city,
	state,
	postal_code
)
INCLUDE (user_id,number,street,city,state,postal_code);
-- ddl-end --



-- [ Created constraints ] --
-- object: users_ak | type: CONSTRAINT --
-- ALTER TABLE public.users DROP CONSTRAINT IF EXISTS users_ak CASCADE;
ALTER TABLE public.users ADD CONSTRAINT users_ak UNIQUE (email);
-- ddl-end --



-- [ Created foreign keys ] --
-- object: fk_addresses_user | type: CONSTRAINT --
-- ALTER TABLE public.addresses DROP CONSTRAINT IF EXISTS fk_addresses_user CASCADE;
ALTER TABLE public.addresses ADD CONSTRAINT fk_addresses_user FOREIGN KEY (user_id)
REFERENCES public.users (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

