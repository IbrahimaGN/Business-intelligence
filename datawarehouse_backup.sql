PGDMP                       |            Datawarehouse     16.4 (Ubuntu 16.4-1.pgdg22.04+1)     16.4 (Ubuntu 16.4-1.pgdg22.04+1) /    B           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            C           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            D           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            E           1262    16770    Datawarehouse    DATABASE     {   CREATE DATABASE "Datawarehouse" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'fr_FR.UTF-8';
    DROP DATABASE "Datawarehouse";
                clients    false            �            1259    16772    dimension_client    TABLE     �   CREATE TABLE public.dimension_client (
    client_id integer NOT NULL,
    prenom character varying(50),
    nom character varying(50),
    telephone character varying(20),
    sexe character(1),
    type_client character(1)
);
 $   DROP TABLE public.dimension_client;
       public         heap    clients    false            �            1259    16771    dimension_client_client_id_seq    SEQUENCE     �   CREATE SEQUENCE public.dimension_client_client_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.dimension_client_client_id_seq;
       public          clients    false    216            F           0    0    dimension_client_client_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.dimension_client_client_id_seq OWNED BY public.dimension_client.client_id;
          public          clients    false    215            �            1259    16793    dimension_date    TABLE     �   CREATE TABLE public.dimension_date (
    date_id integer NOT NULL,
    date_commande date NOT NULL,
    jour integer,
    mois integer,
    trimestre integer,
    annee integer
);
 "   DROP TABLE public.dimension_date;
       public         heap    clients    false            �            1259    16792    dimension_date_date_id_seq    SEQUENCE     �   CREATE SEQUENCE public.dimension_date_date_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.dimension_date_date_id_seq;
       public          clients    false    222            G           0    0    dimension_date_date_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.dimension_date_date_id_seq OWNED BY public.dimension_date.date_id;
          public          clients    false    221            �            1259    16786    dimension_produit    TABLE     �   CREATE TABLE public.dimension_produit (
    produit_id integer NOT NULL,
    designation character varying(100),
    prix_unitaire numeric(10,2)
);
 %   DROP TABLE public.dimension_produit;
       public         heap    clients    false            �            1259    16785     dimension_produit_produit_id_seq    SEQUENCE     �   CREATE SEQUENCE public.dimension_produit_produit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.dimension_produit_produit_id_seq;
       public          clients    false    220            H           0    0     dimension_produit_produit_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.dimension_produit_produit_id_seq OWNED BY public.dimension_produit.produit_id;
          public          clients    false    219            �            1259    16779    dimension_vendeur    TABLE     �   CREATE TABLE public.dimension_vendeur (
    vendeur_id integer NOT NULL,
    prenom character varying(50),
    nom character varying(50),
    telephone character varying(20),
    sexe character(1)
);
 %   DROP TABLE public.dimension_vendeur;
       public         heap    clients    false            �            1259    16778     dimension_vendeur_vendeur_id_seq    SEQUENCE     �   CREATE SEQUENCE public.dimension_vendeur_vendeur_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.dimension_vendeur_vendeur_id_seq;
       public          clients    false    218            I           0    0     dimension_vendeur_vendeur_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.dimension_vendeur_vendeur_id_seq OWNED BY public.dimension_vendeur.vendeur_id;
          public          clients    false    217            �            1259    16800 
   fait_vente    TABLE       CREATE TABLE public.fait_vente (
    vente_id integer NOT NULL,
    client_id integer NOT NULL,
    vendeur_id integer NOT NULL,
    produit_id integer NOT NULL,
    date_id integer NOT NULL,
    quantite integer NOT NULL,
    montant_total numeric(10,2) NOT NULL
);
    DROP TABLE public.fait_vente;
       public         heap    clients    false            �            1259    16799    fait_vente_vente_id_seq    SEQUENCE     �   CREATE SEQUENCE public.fait_vente_vente_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.fait_vente_vente_id_seq;
       public          clients    false    224            J           0    0    fait_vente_vente_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.fait_vente_vente_id_seq OWNED BY public.fait_vente.vente_id;
          public          clients    false    223            �           2604    16775    dimension_client client_id    DEFAULT     �   ALTER TABLE ONLY public.dimension_client ALTER COLUMN client_id SET DEFAULT nextval('public.dimension_client_client_id_seq'::regclass);
 I   ALTER TABLE public.dimension_client ALTER COLUMN client_id DROP DEFAULT;
       public          clients    false    216    215    216            �           2604    16796    dimension_date date_id    DEFAULT     �   ALTER TABLE ONLY public.dimension_date ALTER COLUMN date_id SET DEFAULT nextval('public.dimension_date_date_id_seq'::regclass);
 E   ALTER TABLE public.dimension_date ALTER COLUMN date_id DROP DEFAULT;
       public          clients    false    222    221    222            �           2604    16789    dimension_produit produit_id    DEFAULT     �   ALTER TABLE ONLY public.dimension_produit ALTER COLUMN produit_id SET DEFAULT nextval('public.dimension_produit_produit_id_seq'::regclass);
 K   ALTER TABLE public.dimension_produit ALTER COLUMN produit_id DROP DEFAULT;
       public          clients    false    220    219    220            �           2604    16782    dimension_vendeur vendeur_id    DEFAULT     �   ALTER TABLE ONLY public.dimension_vendeur ALTER COLUMN vendeur_id SET DEFAULT nextval('public.dimension_vendeur_vendeur_id_seq'::regclass);
 K   ALTER TABLE public.dimension_vendeur ALTER COLUMN vendeur_id DROP DEFAULT;
       public          clients    false    217    218    218            �           2604    16803    fait_vente vente_id    DEFAULT     z   ALTER TABLE ONLY public.fait_vente ALTER COLUMN vente_id SET DEFAULT nextval('public.fait_vente_vente_id_seq'::regclass);
 B   ALTER TABLE public.fait_vente ALTER COLUMN vente_id DROP DEFAULT;
       public          clients    false    224    223    224            7          0    16772    dimension_client 
   TABLE DATA           `   COPY public.dimension_client (client_id, prenom, nom, telephone, sexe, type_client) FROM stdin;
    public          clients    false    216   ?9       =          0    16793    dimension_date 
   TABLE DATA           ^   COPY public.dimension_date (date_id, date_commande, jour, mois, trimestre, annee) FROM stdin;
    public          clients    false    222   \9       ;          0    16786    dimension_produit 
   TABLE DATA           S   COPY public.dimension_produit (produit_id, designation, prix_unitaire) FROM stdin;
    public          clients    false    220   y9       9          0    16779    dimension_vendeur 
   TABLE DATA           U   COPY public.dimension_vendeur (vendeur_id, prenom, nom, telephone, sexe) FROM stdin;
    public          clients    false    218   �9       ?          0    16800 
   fait_vente 
   TABLE DATA           s   COPY public.fait_vente (vente_id, client_id, vendeur_id, produit_id, date_id, quantite, montant_total) FROM stdin;
    public          clients    false    224   �9       K           0    0    dimension_client_client_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.dimension_client_client_id_seq', 1, false);
          public          clients    false    215            L           0    0    dimension_date_date_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.dimension_date_date_id_seq', 1, false);
          public          clients    false    221            M           0    0     dimension_produit_produit_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.dimension_produit_produit_id_seq', 1, false);
          public          clients    false    219            N           0    0     dimension_vendeur_vendeur_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.dimension_vendeur_vendeur_id_seq', 1, false);
          public          clients    false    217            O           0    0    fait_vente_vente_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.fait_vente_vente_id_seq', 1, false);
          public          clients    false    223            �           2606    16777 &   dimension_client dimension_client_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.dimension_client
    ADD CONSTRAINT dimension_client_pkey PRIMARY KEY (client_id);
 P   ALTER TABLE ONLY public.dimension_client DROP CONSTRAINT dimension_client_pkey;
       public            clients    false    216            �           2606    16798 "   dimension_date dimension_date_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.dimension_date
    ADD CONSTRAINT dimension_date_pkey PRIMARY KEY (date_id);
 L   ALTER TABLE ONLY public.dimension_date DROP CONSTRAINT dimension_date_pkey;
       public            clients    false    222            �           2606    16791 (   dimension_produit dimension_produit_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.dimension_produit
    ADD CONSTRAINT dimension_produit_pkey PRIMARY KEY (produit_id);
 R   ALTER TABLE ONLY public.dimension_produit DROP CONSTRAINT dimension_produit_pkey;
       public            clients    false    220            �           2606    16784 (   dimension_vendeur dimension_vendeur_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.dimension_vendeur
    ADD CONSTRAINT dimension_vendeur_pkey PRIMARY KEY (vendeur_id);
 R   ALTER TABLE ONLY public.dimension_vendeur DROP CONSTRAINT dimension_vendeur_pkey;
       public            clients    false    218            �           2606    16805    fait_vente fait_vente_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.fait_vente
    ADD CONSTRAINT fait_vente_pkey PRIMARY KEY (vente_id);
 D   ALTER TABLE ONLY public.fait_vente DROP CONSTRAINT fait_vente_pkey;
       public            clients    false    224            �           1259    16826    idx_fait_vente_client    INDEX     Q   CREATE INDEX idx_fait_vente_client ON public.fait_vente USING btree (client_id);
 )   DROP INDEX public.idx_fait_vente_client;
       public            clients    false    224            �           1259    16829    idx_fait_vente_date    INDEX     M   CREATE INDEX idx_fait_vente_date ON public.fait_vente USING btree (date_id);
 '   DROP INDEX public.idx_fait_vente_date;
       public            clients    false    224            �           1259    16828    idx_fait_vente_produit    INDEX     S   CREATE INDEX idx_fait_vente_produit ON public.fait_vente USING btree (produit_id);
 *   DROP INDEX public.idx_fait_vente_produit;
       public            clients    false    224            �           1259    16827    idx_fait_vente_vendeur    INDEX     S   CREATE INDEX idx_fait_vente_vendeur ON public.fait_vente USING btree (vendeur_id);
 *   DROP INDEX public.idx_fait_vente_vendeur;
       public            clients    false    224            �           2606    16806 $   fait_vente fait_vente_client_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.fait_vente
    ADD CONSTRAINT fait_vente_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.dimension_client(client_id);
 N   ALTER TABLE ONLY public.fait_vente DROP CONSTRAINT fait_vente_client_id_fkey;
       public          clients    false    224    216    3222            �           2606    16821 "   fait_vente fait_vente_date_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.fait_vente
    ADD CONSTRAINT fait_vente_date_id_fkey FOREIGN KEY (date_id) REFERENCES public.dimension_date(date_id);
 L   ALTER TABLE ONLY public.fait_vente DROP CONSTRAINT fait_vente_date_id_fkey;
       public          clients    false    3228    224    222            �           2606    16816 %   fait_vente fait_vente_produit_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.fait_vente
    ADD CONSTRAINT fait_vente_produit_id_fkey FOREIGN KEY (produit_id) REFERENCES public.dimension_produit(produit_id);
 O   ALTER TABLE ONLY public.fait_vente DROP CONSTRAINT fait_vente_produit_id_fkey;
       public          clients    false    224    220    3226            �           2606    16811 %   fait_vente fait_vente_vendeur_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.fait_vente
    ADD CONSTRAINT fait_vente_vendeur_id_fkey FOREIGN KEY (vendeur_id) REFERENCES public.dimension_vendeur(vendeur_id);
 O   ALTER TABLE ONLY public.fait_vente DROP CONSTRAINT fait_vente_vendeur_id_fkey;
       public          clients    false    3224    218    224            7      x������ � �      =      x������ � �      ;      x������ � �      9      x������ � �      ?      x������ � �     