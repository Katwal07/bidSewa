import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:nepa_bid/core/error/exception.dart';
import 'package:nepa_bid/core/network/api_client.dart';
import 'package:nepa_bid/core/network/network_const/api_endpoint_urls.dart';
import 'package:nepa_bid/data/auth/model/signin_req_params.dart';
import 'package:nepa_bid/data/auth/model/user_response.dart';
import 'package:nepa_bid/service_locator.dart';
import '../model/signup_req_params.dart';
import '../model/signup_req_params_for_auctioneer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

part 'auth_api_service.dart';
part 'auth_local_service.dart';
part 'token_service.dart';