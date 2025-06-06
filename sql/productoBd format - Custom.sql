PGDMP                      }            pruebaProducto    17.5    17.5     D           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            E           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            F           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            G           1262    16388    pruebaProducto    DATABASE     �   CREATE DATABASE "pruebaProducto" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Chile.utf8';
     DROP DATABASE "pruebaProducto";
                     postgres    false            �            1259    16392    Bodega    TABLE     x   CREATE TABLE public."Bodega" (
    id character(15) NOT NULL,
    estado numeric DEFAULT 0,
    nombre character(50)
);
    DROP TABLE public."Bodega";
       public         heap r       postgres    false            �            1259    16407    Moneda    TABLE        CREATE TABLE public."Moneda" (
    id character(15) NOT NULL,
    nombre character(50),
    estado numeric(11,0) DEFAULT 20
);
    DROP TABLE public."Moneda";
       public         heap r       postgres    false            �            1259    16389    Producto    TABLE       CREATE TABLE public."Producto" (
    codigo character(15) NOT NULL,
    nombre character(50),
    bodega_id character(15),
    sucursal_id character(15),
    moneda_id character(15),
    precio numeric,
    estado numeric,
    descripcion character(100)
);
    DROP TABLE public."Producto";
       public         heap r       postgres    false            �            1259    16399    Sucursal    TABLE     �   CREATE TABLE public."Sucursal" (
    id character(15) NOT NULL,
    nombre character(50),
    estado numeric DEFAULT 0,
    bodega_id character(15)
);
    DROP TABLE public."Sucursal";
       public         heap r       postgres    false            �            1259    16416 	   intereses    TABLE     o   CREATE TABLE public.intereses (
    id character(15) NOT NULL,
    nombre character(50),
    estado numeric
);
    DROP TABLE public.intereses;
       public         heap r       postgres    false            �            1259    16421    registro_intereses    TABLE     �   CREATE TABLE public.registro_intereses (
    intereses_id character(15),
    producto_id character(15),
    id integer NOT NULL
);
 &   DROP TABLE public.registro_intereses;
       public         heap r       postgres    false            �            1259    16448    registro_intereses_id_seq    SEQUENCE     �   CREATE SEQUENCE public.registro_intereses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.registro_intereses_id_seq;
       public               postgres    false    222            H           0    0    registro_intereses_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.registro_intereses_id_seq OWNED BY public.registro_intereses.id;
          public               postgres    false    223            �           2604    16449    registro_intereses id    DEFAULT     ~   ALTER TABLE ONLY public.registro_intereses ALTER COLUMN id SET DEFAULT nextval('public.registro_intereses_id_seq'::regclass);
 D   ALTER TABLE public.registro_intereses ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    223    222            <          0    16392    Bodega 
   TABLE DATA           6   COPY public."Bodega" (id, estado, nombre) FROM stdin;
    public               postgres    false    218   <       >          0    16407    Moneda 
   TABLE DATA           6   COPY public."Moneda" (id, nombre, estado) FROM stdin;
    public               postgres    false    220   y       ;          0    16389    Producto 
   TABLE DATA           t   COPY public."Producto" (codigo, nombre, bodega_id, sucursal_id, moneda_id, precio, estado, descripcion) FROM stdin;
    public               postgres    false    217   �       =          0    16399    Sucursal 
   TABLE DATA           C   COPY public."Sucursal" (id, nombre, estado, bodega_id) FROM stdin;
    public               postgres    false    219   �       ?          0    16416 	   intereses 
   TABLE DATA           7   COPY public.intereses (id, nombre, estado) FROM stdin;
    public               postgres    false    221   Y       @          0    16421    registro_intereses 
   TABLE DATA           K   COPY public.registro_intereses (intereses_id, producto_id, id) FROM stdin;
    public               postgres    false    222   �       I           0    0    registro_intereses_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.registro_intereses_id_seq', 52, true);
          public               postgres    false    223            �           2606    16456    Bodega Bodega_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public."Bodega"
    ADD CONSTRAINT "Bodega_pkey" PRIMARY KEY (id);
 @   ALTER TABLE ONLY public."Bodega" DROP CONSTRAINT "Bodega_pkey";
       public                 postgres    false    218            �           2606    16470    Moneda Moneda_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public."Moneda"
    ADD CONSTRAINT "Moneda_pkey" PRIMARY KEY (id);
 @   ALTER TABLE ONLY public."Moneda" DROP CONSTRAINT "Moneda_pkey";
       public                 postgres    false    220            �           2606    16490    Producto Producto_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public."Producto"
    ADD CONSTRAINT "Producto_pkey" PRIMARY KEY (codigo);
 D   ALTER TABLE ONLY public."Producto" DROP CONSTRAINT "Producto_pkey";
       public                 postgres    false    217            �           2606    16548    intereses intereses_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.intereses
    ADD CONSTRAINT intereses_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.intereses DROP CONSTRAINT intereses_pkey;
       public                 postgres    false    221            �           2606    16454 *   registro_intereses registro_intereses_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.registro_intereses
    ADD CONSTRAINT registro_intereses_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.registro_intereses DROP CONSTRAINT registro_intereses_pkey;
       public                 postgres    false    222            �           2606    16528    Sucursal sucursal_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public."Sucursal"
    ADD CONSTRAINT sucursal_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public."Sucursal" DROP CONSTRAINT sucursal_pkey;
       public                 postgres    false    219            <   -   x�3T@��I�)��
�
D.\�8�`�.C�H0$F��� k�l      >   0   x�3P@�.�9�E
� N.C4g� �� b�&�ZZ�O�!1z\\\ e[      ;     x��W[r�0�&�`uL ���
��DZ|����K���4\Z�1���p��}%BIQ��F$~� �#�,�,���zKWI�~0�(z��_��SW!?daF�(���?�}���v�k��@Pt(�L��	BMnB���L`M,4�������X0����`�6���/�O��'v����z)?�C�_𔧋��o��pP�*���Ɉ����d�]�F���V��6J��{A�v>�r�F�j��j4S���uA=	X�!�jȹ�l鰋2��,#N��,��6��ugi2
�8���!W�"wGL*D�3�:�"��x��� �M*j(�[a@��yE?�<��O]a�0��@�Pp��PW�0����
:IQq�����|�z`#���@��"����l��c�'h�Yg�[�n�h��h4��x�>'v�o��G��Li#��4FŨ�I<�Qs�	��璥N#��_�m��l(>	;]0{Ot��]�-�SL�/��ΧX��p:z_���n���Xj�q����
~Y�!�gWA�      =   j   x�3P@�Ωy%E�9
�NNT.C4��ɥE�@S�(0����j���TEs�1.C3)0����j���lE�m.s\����j���2
����� ��u�      ?   Q   x�3P@�9��d&�+8��D|SKs�7b��!�)�E�$b�&��R�I�g�������V�d���!1z\\\ ��4�      @   I  x���Qn�0���;�D��%v���F�e�61�/�^~L#�d����E��o��q��E�Ev�7�n˅�t1k,���cH�Tj�M\�]�]�5յ���p4i�Wlӱ����ʷ]�
�+]ҳ.$(]ѢݍqZ��`�ϕ��*���~��ӭO��� ����V�IKW-ݙ��h�
RBv�o5U��6��F�0L�V�ѓ0ή �6>��Y�m�>�L7vM�5q��0����M�q��\Y~E0ݟ�@��g����"j��Kq'�g ��;��h�+�6��i#��
������8�@��%D�1ݜ����*����7'd����G�Q�     